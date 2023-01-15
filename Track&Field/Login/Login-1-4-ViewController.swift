//
//  Login-1-4-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//済・要関連付け
//なし

import UIKit
//import Firebase //FB
//import FirebaseAuth
//import FirebaseFirestore

class Login_1_4_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupname_TF: UITextField!
    @IBOutlet weak var bottom_Const: NSLayoutConstraint!
    @IBOutlet weak var groupName_Label: UILabel!
    @IBOutlet weak var regist_picture: UIImageView!
    
    var groupName : String = ""
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    
    //    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        groupname_TF.delegate = self
        
        groupname_TF.addTarget(self, action: #selector(Login_1_4_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        //key
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        //        bottom_Const.constant = UIScreen.main.bounds.size.height - (47+277+42+20)
        bottom_Const.constant = 100
        
        groupName_Label.text = ""
        groupName_Label.layer.cornerRadius = 20
        groupName_Label.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
        groupName_Label.layer.borderWidth = 1.0 // 枠線の太さ
        groupName_Label.layer.shadowColor = UIColor.black.cgColor //　影の色
        groupName_Label.layer.shadowOpacity = 0.25  //影の濃さ
        groupName_Label.layer.shadowRadius = 4.0 // 影のぼかし量
        groupName_Label.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        // Do any additional setup after loading the view.
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        return true //戻り値
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        groupName = textField.text!
        print("groupName: \(groupName)")
        
    }
    
    
    //key
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let keyboardHeight = notification.keyboardHeight,
              let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            
            //            if  UIScreen.main.bounds.size.height - (47+277+42+20) < keyboardHeight + 20 {
            self.bottom_Const.constant = keyboardHeight
            //            }
            
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }
        
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
            
            // アニメーションさせたい実装を行う
            //            self.bottom_Const.constant = UIScreen.main.bounds.size.height - (47+277+42+20)
            self.bottom_Const.constant = 100
            
        }
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        regist_picture.image = p_pushed_s
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        regist_picture.image = p_nonpushed_s
    }
    
    @IBAction func register_tapped_1_4() {
        regist_picture.image = p_nonpushed_s
        //グループ名確認
        if groupName == "" {
            OtherHost.alertDef(view: self, title: "グループ名が\n正しく入力されていません", message: "グループ名を\nもう一度入れ直してください。")
            print("error: groupName not found")
            
        } else {
            UserDefaults.standard.set(self.groupName, forKey: "Setup_groupname")
            //MARK: ★navigation遷移
            self.performSegue(withIdentifier: "go-1-5", sender: self)
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
