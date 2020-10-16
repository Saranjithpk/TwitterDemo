//
//  UIViewController.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import UIKit

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(view : UIView) {
        let loaderView = UIView.init(frame: view.bounds)
        loaderView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = loaderView.center
        
        DispatchQueue.main.async {
            loaderView.addSubview(activityIndicator)
            view.addSubview(loaderView)
        }
        
        vSpinner = loaderView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
