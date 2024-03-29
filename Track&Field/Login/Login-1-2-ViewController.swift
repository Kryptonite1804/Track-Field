//
//  Login-1-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//
//済・要確認

import UIKit
import Firebase //FB
import FirebaseAuth

class Login_1_2_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var username_TF: UITextField!
    @IBOutlet weak var password_TF: UITextField!
    @IBOutlet weak var repassword_TF: UITextField!
    
    //design
    @IBOutlet weak var email_Label: UILabel!
    @IBOutlet weak var username_Label: UILabel!
    @IBOutlet weak var password_Label: UILabel!
    @IBOutlet weak var repassword_Label: UILabel!
    
    @IBOutlet weak var regist_picture: UIImageView!
    @IBOutlet weak var bottom_Const: NSLayoutConstraint!
    
    var emailadress :String = ""
    var username :String = ""
    var pass :String = ""
    var repass :String = ""
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let tfArray = [email_TF,username_TF,password_TF,repassword_TF]
        for tf in 0...3 {
            let electedTf = tfArray[tf]
            electedTf?.delegate = self
            electedTf?.tag = tf
            electedTf?.addTarget(self, action: #selector(Login_1_2_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        
        password_TF.isSecureTextEntry = true
        repassword_TF.isSecureTextEntry = true
        
        
        //key
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        let loginButton = [email_Label,username_Label,password_Label,repassword_Label]
        for (label) in loginButton {
            OtherHost.setLabelDesign(label: label!, cornerRadius: 20, borderColor: Asset.lineColor.color.cgColor, borderWidth: 1.0)
            OtherHost.setLabelDesignAdditional(label: label!, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.25, shadowRadius: 4.0, shadowOffset: CGSize(width: 3.0, height: 3.0))
        }
        
        //bottom_Const.constant = UIScreen.main.bounds.size.height - (47+448+42+20)
        bottom_Const.constant = 100
        
//        KeyBoardHost.setNotification()
//        KeyBoardHost.keyboardWillShow2(bottom_Const: bottom_Const)
//        KeyBoardHost.keyboardWillHide2(bottom_Const: bottom_Const)
        
        // Do any additional setup after loading the view.
    }
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.tag == 0 {
            emailadress = textField.text!
            print("emailadress: \(emailadress)")
            
        } else if textField.tag == 1 {
            username = textField.text!
            print("username: \(username)")
            
        } else if textField.tag == 2 {
            pass = textField.text!
            print("password: \(pass)")
        } else if textField.tag == 3 {
            repass = textField.text!
            print("password: \(repass)")
        }
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
            self.bottom_Const.constant = keyboardHeight
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
            //        bottom_Const.constant = UIScreen.main.bounds.size.height - (47+448+42+20)
            self.bottom_Const.constant = 100
        }
    }
    
    @IBAction func tap(_ sender: UIButton) {
        regist_picture.image = p_pushed_s
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        regist_picture.image = p_nonpushed_s
    }
    
    @IBAction func register_tapped() {
        regist_picture.image = p_nonpushed_s
        
        //入力項目の確認...
        var confirmBool = true
        let confirmDict = ["メールアドレス":emailadress,"ユーザー名":username,"パスワード":pass,"再入力パスワード":repass]
        for (key, value) in confirmDict {
            if value == "" {
                confirmBool = false
                AlertHost.alertDef(view: self ,title: "\(key)が\n正しく入力されていません", message: "\(key)を\nもう一度入れ直してください。")
                print("error: \(key) not found.")
            }
        }
        
        if pass != repass {
            confirmBool = false
            AlertHost.alertDef(view: self,title: "パスワードが一致していません", message: "パスワードが再入力時と一致していません。\nもう一度入れ直してください。")
            print("error: password do not much.")
            
        } else if pass.count < 7 {
            confirmBool = false
            AlertHost.alertDef(view: self,title: "弱いパスワードです", message: "このパスワードは文字数が少なすぎます。\n最低7文字以上入力してください。")
            print("error: password is weak.")
        }
        
        if confirmBool {
            OtherHost.activityIndicatorView(view: view).startAnimating()
            Auth.auth().createUser (withEmail: emailadress, password: pass) {
                authResult, error in
                print("succeed: signup_createUser")
                if let user = authResult?.user {
                    UserDefaults.standard.set(self.username, forKey: "Setup_username")
                    OtherHost.activityIndicatorView(view: self.view).stopAnimating()  //AIV
                    print(user)
                    //MARK: ★navigation遷移
                    self.performSegue(withIdentifier: "go-1-2-1", sender: self)
                    dump(user)
                    
                } else {
                    dump(error)
                    print("エラー")
                    OtherHost.activityIndicatorView(view: self.view).stopAnimating()  //AIV
                    AlertHost.alertDef(view: self,title: "エラー", message: "何らかのエラーが発生しました。\n以下の項目に当てはまる場合、エラーが発生します。\n・パスワードが明らかに脆弱\n・無効なメールアドレスをしようしている\n・メールアドレスがすでに使われている\nもう一度ご確認の上、ご登録ください。")
                    print("error: unknown error happend.")
                    //
                }
            }
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


extension Notification {
    // キーボードの高さ
    var keyboardHeight: CGFloat? {
        return (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
    // キーボードのアニメーション時間
    var keybaordAnimationDuration: TimeInterval? {
        return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    }
    // キーボードのアニメーション曲線
    var keyboardAnimationCurve: UInt? {
        return self.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
    }
}
