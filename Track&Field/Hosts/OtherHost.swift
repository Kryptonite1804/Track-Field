//
//  Alert.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/12/17.
//

import UIKit
import SafariServices

class OtherHost {
    
    
    //AIV
    static func activityIndicatorView(view:UIView) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }
    
    //SafariVC
    static func openForm(view: UIViewController) {
        let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = view as? any SFSafariViewControllerDelegate
            view.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    //cgAffineTransform
    static func cgAffineTransform(_ pi:CGFloat) -> CGAffineTransform {
        return CGAffineTransform(rotationAngle: .pi/pi)
    }
    
    static func uiDesignSet(ui: UI)
    
}
