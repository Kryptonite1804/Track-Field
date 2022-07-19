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
    
    @IBOutlet weak var bottom_Const: NSLayoutConstraint!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var emailadress :String = ""
    var username :String = ""
    var pass :String = ""
    var repass :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TF
        email_TF.delegate = self
        username_TF.delegate = self
        password_TF.delegate = self
        repassword_TF.delegate = self
        
        //TF
        email_TF.tag = 0
        username_TF.tag = 1
        password_TF.tag = 2
        repassword_TF.tag = 3
        
        password_TF.isSecureTextEntry = true
        repassword_TF.isSecureTextEntry = true
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
        //TF
        email_TF.addTarget(self, action: #selector(Login_1_2_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        username_TF.addTarget(self, action: #selector(Login_1_2_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        password_TF.addTarget(self, action: #selector(Login_1_2_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        repassword_TF.addTarget(self, action: #selector(Login_1_2_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
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
            loginButtonNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            loginButtonNum?.layer.borderWidth = 1.0 // 枠線の太さ
            loginButtonNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            loginButtonNum?.layer.shadowOpacity = 0.25  //影の濃さ
            loginButtonNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            loginButtonNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        }
        
        
        
        bottom_Const.constant = UIScreen.main.bounds.size.height - (460+44)
        
        
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
            
            if UIScreen.main.bounds.size.height - (460+44) < keyboardHeight + 10 {
            
                self.bottom_Const.constant = keyboardHeight + 10
                
            }
            
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
            self.bottom_Const.constant = UIScreen.main.bounds.size.height - (460+44)
            
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
    
    
    
    
    @IBAction func register_tapped() {
        
        //入力項目の確認...
        
        
            
            if emailadress == "" {
                alert(title: "メールアドレスが\n正しく入力されていません", message: "メールアドレスを\nもう一度入れ直してください。")
                print("error: emailadress not found")
                
            } else if username == "" {
                alert(title: "ユーザー名が\n正しく入力されていません", message: "ユーザー名を\nもう一度入れ直してください。")
                print("error: username not found")
                
            } else if pass == "" {
                alert(title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
                print("error: password not found")
                
            } else if repass == "" {
                alert(title: "再入力パスワードが\n正しく入力されていません", message: "再入力パスワードを\nもう一度入れ直してください。")
                print("error: repassword not found")
                
            } else if pass != repass {
                alert(title: "パスワードが一致していません", message: "パスワードが再入力時と一致していません。\nもう一度入れ直してください。")
                print("error: repassword not found")
                
            } else {
                
                activityIndicatorView.startAnimating()  //AIV
                
                Auth.auth().createUser (withEmail: emailadress, password: pass) {
                    authResult, error in
                print("succeed: signup_createUser")
                    
                    
                    UserDefaults.standard.set(self.username, forKey: "Setup_username")
                    self.activityIndicatorView.stopAnimating()  //AIV
                    
                    //MARK: ★navigation遷移
                    self.performSegue(withIdentifier: "go-1-2-1", sender: self)

                    
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
