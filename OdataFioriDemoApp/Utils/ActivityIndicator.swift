//
//  ActivityIndicator.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 12/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFiori

protocol ActivityIndicator {}

extension ActivityIndicator where Self: UIViewController {
    
    func initWithActivityIndicator() -> FUIProcessingIndicatorView {
        
        let processingIndicatorView = FUIProcessingIndicatorView(frame: CGRect(x: 0, y: 0, width: 180, height: 80))
        // Helps to find the position of activity indicator on different landscapes
        processingIndicatorView.autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth]
        processingIndicatorView.text = "Loading Data"
        processingIndicatorView.isTextLabelHidden = false
        return processingIndicatorView
    }
    
    func showActivityIndicator(_ activityIndicatorView: FUIProcessingIndicatorView) {
        activityIndicatorView.startAnimating(easeIn: true)
    }
    
    func hideActivityIndicator(_ activityIndicatorView: FUIProcessingIndicatorView) {
        activityIndicatorView.stopAnimating(easeOut: true)
        self.dismissIndicator(activityIndicatorView)
    }
    func dismissIndicator(_ activityIndicatorView: FUIProcessingIndicatorView) {
        activityIndicatorView.dismiss(animated: true)
    }
    
}
