//
//  UIViewController+Alerts.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/5/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle:String?=nil,
                   message:String?=nil,
                   defaultAtion:@escaping ()->()={}) {
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "action.ok".localized, style: .default, handler: { (_) in
            defaultAtion()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    /** shows loading indicator view above current controller's view */
    func showLoading(_ show:Bool = true) {
        let loadingIndicatorTag = 2702
        
        if show {
            self.showLoading(false)
            
            view.isUserInteractionEnabled = false
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            indicator.tag = loadingIndicatorTag
            indicator.startAnimating()
            view.addSubview(indicator)
            
            let xConstraint = NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
            
            let yConstraint = NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            view.addConstraints([xConstraint, yConstraint])
            
        } else {
            view.viewWithTag(loadingIndicatorTag)?.removeFromSuperview()
            view.isUserInteractionEnabled = true
        }
    }
}
