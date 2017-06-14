//
//  Notifier.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit

protocol Notifier {
    func displayAlert(title: String, message: String, buttonText: String)
}

extension Notifier where Self: UIViewController {
    
    func displayAlert(title: String, message: String, buttonText: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create the actions
        let buttonAction = UIAlertAction(title: buttonText, style: UIAlertActionStyle.default) {
            UIAlertAction in
            alertController.dismiss(animated: true, completion: nil)
        }
        // Add the actions
        alertController.addAction(buttonAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

