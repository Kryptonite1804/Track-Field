//
//  Alert.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/12/17.
//

import UIKit
import SafariServices

class OtherHost {
    
    //Alert
    //    static func alertDef(view: UIViewController, title: String, message: String) {
    //        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //        view.present(alertVC, animated: true)
    //    }
    
    static func alertDef(view: UIViewController, title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        view.present(alertVC, animated: true)
    }
    
    
    //        var alertController: UIAlertController!
    //        func alertDef(view: UIViewController, title: String, message: String) {
    //        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //        view.present(alertController, animated: true)
    //    }
    
    
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
    
    static func openForm(view: UIViewController) {
        let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = view as? any SFSafariViewControllerDelegate
            view.present(safariViewController, animated: true, completion: nil)
        }
    }
    
//
//    func toolbar(view:UIView) {
//        @objc func done() {
//            view.endEditing(true)
//        }
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
//    }
}
