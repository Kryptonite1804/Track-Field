//
//  Login-2-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//MARK: ログイン箇所

import UIKit
import Firebase //FB
import FirebaseAuth
import FirebaseFirestore

class Login_2_1_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var checkemail_TF: UITextField!
    @IBOutlet weak var checkpassword_TF: UITextField!
    
    @IBOutlet weak var mailadress_Label: UILabel!
    @IBOutlet weak var password_Label: UILabel!
    
    @IBOutlet weak var bottom_Const: NSLayoutConstraint!  //key
    
    @IBOutlet weak var login_picture: UIImageView!
    
    var emailadress :String = ""
    var pass :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TF
        checkemail_TF.delegate = self
        checkpassword_TF.delegate = self
        
        checkemail_TF.tag = 0
        checkpassword_TF.tag = 1
        
        checkpassword_TF.isSecureTextEntry = true
        
        checkemail_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        checkpassword_TF.addTarget(self, action: #selector(Login_2_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        // Do any additional setup after loading the view.
        
        //key
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        //        self.bottom_Const.constant = UIScreen.main.bounds.size.height - (47+254+42)
        bottom_Const.constant = 100
        
        let labelArray = [mailadress_Label,password_Label]
        for (label) in labelArray {
            OtherHost.setLabelDesign(label: label!, cornerRadius: 20, borderColor: Asset.lineColor.color.cgColor, borderWidth: 1.0)
            OtherHost.setLabelDesignAdditional(label: label!, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.25, shadowRadius: 4.0, shadowOffset: CGSize(width: 3.0, height: 3.0))
        }
        
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
            pass = textField.text!
            print("password: \(pass)")
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
            //            if UIScreen.main.bounds.size.height - (47+254+42) < keyboardHeight + 10 {
            
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
                       options: UIView.AnimationOptions(rawValue: KeyboardAnimationCurve)) { [self] in
            //            self.bottom_Const.constant = UIScreen.main.bounds.size.height - (47+254+42)
            self.bottom_Const.constant = 100
        }
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        login_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        login_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func login_2_1() {
        login_picture.image = UIImage(named: "p_nonpushed_s")
        //入力項目の確認
        
        if emailadress == "" {
            AlertHost.alertDef(view: self,title: "メールアドレスが\n正しく入力されていません", message: "メールアドレスを\nもう一度入れ直してください。")
            print("error: emailadress not found")
            
        } else if pass == "" {
            AlertHost.alertDef(view: self,title: "パスワードが\n正しく入力されていません", message: "パスワードを\nもう一度入れ直してください。")
            print("error: password not found")
            
        } else {
            OtherHost.activityIndicatorView(view: view).startAnimating()
            
            Auth.auth().signIn (withEmail: emailadress, password: pass) {
                [weak self] authResult, error in
                
                guard self != nil else { return }
                if (authResult?.user) != nil {
                    //成功
                    print("succeed: login")
                    OtherHost.activityIndicatorView(view: (self?.view)!).stopAnimating()
                    self?.performSegue(withIdentifier: "go-2-2", sender: self)
                    
                } else {
                    //失敗
                    OtherHost.activityIndicatorView(view: (self?.view)!).stopAnimating()
                    AlertHost.alertDef(view: self!,title: "エラー", message: "ログインに失敗しました。\n正しい情報を入力してください。")
                    print("error: password not found")
                    
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
