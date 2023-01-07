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
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var emailadress :String = ""
    var username :String = ""
    var pass :String = ""
    var repass :String = ""
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    
    let alertTitleTemp = "が\n正しく入力されていません"
    let alertMessageTemp = "を\nもう一度入れ直してください。"
    let alertBool = false
    
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
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
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
        for n in 0...loginButton.count - 1 {
            let loginButtonNum = loginButton[n]
            loginButtonNum?.text = ""
            loginButtonNum?.layer.cornerRadius = 20
            loginButtonNum?.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
            loginButtonNum?.layer.borderWidth = 1.0 // 枠線の太さ
            loginButtonNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            loginButtonNum?.layer.shadowOpacity = 0.25  //影の濃さ
            loginButtonNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            loginButtonNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        }
        
        
        //bottom_Const.constant = UIScreen.main.bounds.size.height - (47+448+42+20)
        bottom_Const.constant = 100
        
        
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
            //            if UIScreen.main.bounds.size.height - (47+448+42+20) < keyboardHeight + 10 {
            //                self.bottom_Const.constant = keyboardHeight - 30
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
            //        bottom_Const.constant = UIScreen.main.bounds.size.height - (47+448+42+20)
            self.bottom_Const.constant = 100
        }
    }
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
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
        
        if emailadress == "" {
            alert(title: "メールアドレスが\n正しく入力されていません", message: "メールアドレスを\nもう一度入れ直してください。")
            print("error: emailadress not found.")
            
        } else if username == "" {
            alert(title: "ユーザー名が\n正しく入力されていません", message: "ユーザー名を\nもう一度入れ直してください。")
            print("error: username not found.")
            
        } else if pass == "" {
            alert(title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
            print("error: password not found.")
            
        } else if repass == "" {
            alert(title: "再入力パスワードが\n正しく入力されていません", message: "再入力パスワードを\nもう一度入れ直してください。")
            print("error: repassword not found.")
            
        } else if pass != repass {
            alert(title: "パスワードが一致していません", message: "パスワードが再入力時と一致していません。\nもう一度入れ直してください。")
            print("error: password do not much.")
            
        } else if pass.count < 7 {
            alert(title: "弱いパスワードです", message: "このパスワードは文字数が少なすぎます。\n最低7文字以上入力してください。")
            print("error: password is weak.")
            
        } else {
            
            activityIndicatorView.startAnimating()  //AIV
            
            Auth.auth().createUser (withEmail: emailadress, password: pass) {
                authResult, error in
                print("succeed: signup_createUser")
                
                
                if let user = authResult?.user {
                    
                    UserDefaults.standard.set(self.username, forKey: "Setup_username")
                    self.activityIndicatorView.stopAnimating()  //AIV
                    
                    print(user)
                    //MARK: ★navigation遷移
                    self.performSegue(withIdentifier: "go-1-2-1", sender: self)
                    dump(user)
                    
                } else {
                    
                    
                    dump(error)
                    print("エラー")
                    self.activityIndicatorView.stopAnimating()  //AIV
                    self.alert(title: "エラー", message: "何らかのエラーが発生しました。\n以下の項目に当てはまる場合、エラーが発生します。\n・パスワードが明らかに脆弱\n・無効なメールアドレスをしようしている\n・メールアドレスがすでに使われている\nもう一度ご確認の上、ご登録ください。")
                    print("error: unknown error happend.")
                    
                    
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
