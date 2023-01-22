//
//  KeyBoardHost.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/15.
//

import UIKit

class KeyBoardHost {
    
    
//    var vc: UIViewController!
//
//    init(vc: UIViewController!) {
//        self.vc = vc
//    }
    
    
//    func toolbar() -> UIToolbar {
//
//        //Toolbar
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: (vc?.view.frame.size.width)!, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: vc, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: vc, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
//        return toolbar
//    }
//
//    @objc func done() {
//        vc.view.endEditing(true)
//    }
    
    
    static func toolbar(vc:UIViewController) -> UIToolbar {
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: (vc.view.frame.size.width), height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: vc, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: vc, action: #selector(done(vc:)))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        return toolbar
    }
    
    @objc func done(vc:UIViewController) {
        vc.view.endEditing(true)
    }
    
    
//    
//    
//    static func setNotification() z{
//        
//        //key
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//    }
//    
//    
//    static func keyboardWillShow2(bottom_Const:NSLayoutConstraint) {
//        func keyboardWillShow(_ notification: Notification) {
//            
//            guard let keyboardHeight = notification.keyboardHeight,
//                  let keyboardAnimationDuration = notification.keybaordAnimationDuration,
//                  let KeyboardAnimationCurve = notification.keyboardAnimationCurve
//            else { return }
//            
//            UIView.animate(withDuration: keyboardAnimationDuration,
//                           delay: 0,
//                           options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
//                bottom_Const.constant = keyboardHeight
//            }
//        }
//    }
//    //key
////    @objc func keyboardWillShow(_ notification: Notification, bottom_Const:NSLayoutConstraint) {
////        
////        guard let keyboardHeight = notification.keyboardHeight,
////              let keyboardAnimationDuration = notification.keybaordAnimationDuration,
////              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
////        else { return }
////        
////        UIView.animate(withDuration: keyboardAnimationDuration,
////                       delay: 0,
////                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
////            bottom_Const.constant = keyboardHeight
////        }
////    }
//    
//    
//    static func keyboardWillHide2(bottom_Const:NSLayoutConstraint) {
//        func keyboardWillHide(_ notification: Notification,bottom_Const:NSLayoutConstraint) {
//            guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
//                  let KeyboardAnimationCurve = notification.keyboardAnimationCurve
//            else { return }
//            
//            UIView.animate(withDuration: keyboardAnimationDuration,
//                           delay: 0,
//                           options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
//                // アニメーションさせたい実装を行う
//                bottom_Const.constant = 100
//            }
//        }
//    }
    
    
}

//extension Notification {
//    // キーボードの高さ
//    var keyboardHeight: CGFloat? {
//        return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
//    }
//    // キーボードのアニメーション時間
//    var keybaordAnimationDuration: TimeInterval? {
//        return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
//    }
//    // キーボードのアニメーション曲線
//    var keyboardAnimationCurve: UInt? {
//        return self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
//    }
//}
