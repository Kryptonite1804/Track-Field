//
//  KeyBoardHost.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/15.
//

import UIKit

class KeyBoardHost {
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
