//
//  AlertHost.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/16.
//

import UIKit

class AlertHost {
    
    
    static func alertDef(view: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        view.present(alertVC, animated: true)
    }
    
    
    static func alertDoubleDef(view: UIViewController, alertTitle: String, alertMessage: String, b1Title: String, b1Style: UIAlertAction.Style, b2Title: String, b1Handler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: b1Title, style: b1Style, handler: b1Handler))
        alertVC.addAction(UIAlertAction(title: b2Title, style: .cancel, handler: nil))
        view.present(alertVC, animated: true)
    }
    
}
