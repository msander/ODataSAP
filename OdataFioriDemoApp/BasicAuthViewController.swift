//
//  BasicAuthViewController.swift
//  OdataFioriDemoApp
//
//  Created by Sayantan Chakraborty on 14/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFoundation
import SAPCommon
import SAPFiori

class BasicAuthViewController: UIViewController, SAPURLSessionDelegate, UITextFieldDelegate, Notifier, ActivityIndicator {
    
    private let logger: Logger = Logger.shared(named: "BasicAuthenticationLogger")
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var activityIndicator: FUIProcessingIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var activeTextField: UITextField?
    
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        // Validate
        if (self.usernameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty) {
            displayAlert(title: NSLocalizedString("keyErrorLoginTitle", value: "Error", comment: "XTIT: Title of alert message about login failure."),
                         message: NSLocalizedString("keyErrorLoginBody", value: "Username or Password is missing", comment: "XMSG: Body of alert message about login failure."),
                         buttonText: NSLocalizedString("keyOkButtonLoginError", value: "OK", comment: "XBUT: Title of OK button."))
            return
        }
        
        let sapUrlSession = SAPURLSession(delegate: self)
        
        sapUrlSession.register(SAPcpmsObserver(settingsParameters: Constants.configurationParameters))
        var request = URLRequest(url: Constants.appUrl)
        request.httpMethod = "GET"
        
        //self.showActivityIndicator(activityIndicator)
        self.loginButton.isEnabled = false
        
        let dataTask = sapUrlSession.dataTask(with: request) { data, response, error in
            
            self.loginButton.isEnabled = true
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                let message: String
                
                if let error = error {
                    message = error.localizedDescription
                } else {
                    // default error mesage if no error happened
                    message = NSLocalizedString("keyErrorLogonProcessFailedNoResponseBody", value: "Check you credentials!", comment: "XMSG: Body of alert message about logon process failure.")
                }
                
                DispatchQueue.main.async {
                    //self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyErrorLogonProcessFailedNoResponseTitle", value: "Logon process failed!", comment: "XTIT: Title of alert message about logon process failure."),
                                      message: message,
                                      buttonText: NSLocalizedString("keyOkButtonLogonProcessFailureNoResponse", value: "OK", comment: "XBUT: Title of OK button."))
                }
                return
            }
            
            self.logger.info("Response returned: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) with data: \(String(describing: data))")
            
            // We should check if we got SAML challenge from the server or not
            if !self.isSAMLChallenge(response) {
                
                // Save httpClient for further usage
                self.appDelegate.urlSession = sapUrlSession
                
                self.logger.info("Logged in successfully.")
                
                // Subscribe for remote notification
                self.appDelegate.registerForRemoteNotification()
                
                DispatchQueue.main.async {
                    // Update the UI
                    //self.hideActivityIndicator(self.activityIndicator)
                    self.appDelegate.isLoginSuccessful = true
                    self.dismiss(animated: true, completion: nil)
                    //self.performSegue(withIdentifier: "showSplit", sender: nil)
                }
            } else {
                
                self.logger.error("Loggon process failure.")
                DispatchQueue.main.async {
                    self.hideActivityIndicator(self.activityIndicator)
                    self.displayAlert(title: NSLocalizedString("keyErrorLogonProcessFailedSAMLChallengeTitle", value: "Logon process failed!", comment: "XTIT: Title of alert message about logon process failure."),
                                      message: "(HTTP \(String(response.statusCode)) - \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))",
                        buttonText: NSLocalizedString("keyOkButtonLogonProcessFailureSAMLChallenge", value: "OK", comment: "XBUT: Title of OK button."))
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func isSAMLChallenge(_ response: HTTPURLResponse) -> Bool {
        return response.statusCode == 200 && ((response.allHeaderFields["com.sap.cloud.security.login"]) != nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Notification for keyboard show/hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        // Setting up acitivty indicator.
//        self.activityIndicator = self.initWithActivityIndicator()
//        self.activityIndicator.center = self.view.center
//        self.view.addSubview(self.activityIndicator)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Shrink Table if keyboard show notification comes
    func keyboardWillShow(notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
        if let info = notification.userInfo, let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            // Need to calculate keyboard exact size due to Apple suggestions
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            if let activeField = self.activeTextField, (!self.view.frame.contains(activeField.frame.origin)) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardSize.height)
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    // Resize Table if keyboard hide notification comes
    func keyboardWillHide(notification: NSNotification) {
        // Once keyboard disappears, restore original positions
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.activeTextField?.resignFirstResponder()
        return true
    }
    
    func sapURLSession(_ session: SAPURLSession, task: SAPURLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping(SAPURLSession.AuthChallengeDisposition) -> Void) {
        if challenge.previousFailureCount > 1 {
            completionHandler(.performDefaultHandling)
            return
        }
        // Note: This automatic server trust is for only testing purposes.
        // The intented use is to install certificate to the device. Do not use it productively!
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.use(credential))
        } else {
            let credential = URLCredential(user: self.usernameTextField.text!, password: self.passwordTextField.text!, persistence: .forSession)
            completionHandler(.use(credential))
        }
    }
}
