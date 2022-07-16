//
//  Login-1-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

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
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var emailadress :String = ""
    var username :String = ""
    var pass :String = ""
    var repass :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            // アニメーションさせたい実装を行う
//            self.pass_TF_Const.constant = keyboardHeight + 10
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let keyboardAnimationDuration = notification.keybaordAnimationDuration,
              let KeyboardAnimationCurve = notification.keyboardAnimationCurve
        else { return }

        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) {
//            self.pass_TF_Const.constant = 205
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
                alert(title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
                print("error: repassword not found")
                
            } else if pass != repass {
                alert(title: "パスワードが一致していません", message: "パスワードが再入力時と一致していません。\nもう一度入れ直してください。")
                print("error: repassword not found")
                
            } else {
                
                activityIndicatorView.startAnimating()  //AIV
                
                Auth.auth().createUser (withEmail: emailadress, password: pass) {
                    authResult, error in
                print("succeed: signup_createUser")
                    
                    
                    UserDefaults.standard.set(self.username, forKey: "username")
                    self.activityIndicatorView.stopAnimating()  //AIV
                    
                    //MARK: ★navigation遷移
                    self.performSegue(withIdentifier: "go-1-3", sender: self)

                    
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
