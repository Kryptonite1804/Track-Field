//
//  Login-1-7-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import Firebase //FB
import FirebaseFirestore
import FirebaseAuth

class Login_1_7_ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var groupID_TF: UITextField!
    
    @IBOutlet weak var groupid_Label: UILabel!
    
    @IBOutlet weak var bottom_Const: NSLayoutConstraint!
    
    var groupID :String = ""
    let db = Firestore.firestore()
    var groupUid :String = ""
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        view.addSubview(activityIndicatorView)
        
        //TF
        groupID_TF.delegate = self
        groupID_TF.addTarget(self, action: #selector(Login_1_7_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        //key
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        
        bottom_Const.constant = UIScreen.main.bounds.size.height - 351
        
        groupid_Label.text = ""
        groupid_Label.layer.cornerRadius = 20
        groupid_Label.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        groupid_Label.layer.borderWidth = 1.0 // 枠線の太さ
        groupid_Label.layer.shadowColor = UIColor.black.cgColor //　影の色
        groupid_Label.layer.shadowOpacity = 0.25  //影の濃さ
        groupid_Label.layer.shadowRadius = 4.0 // 影のぼかし量
        groupid_Label.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        

        // Do any additional setup after loading the view.
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        groupID = textField.text!
        print("sharedEmailadress: \(groupID)")  //TF
        
        return true //戻り値
    }
    
    //TF
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        groupID = textField.text!
        print("groupID: \(groupID)")
            
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
            if UIScreen.main.bounds.size.height - 351 < keyboardHeight + 10 {
            
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
            
            self.bottom_Const.constant = UIScreen.main.bounds.size.height - 351
            
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
    
    
    
    
    
    @IBAction func groupjoin_1_7() {
        //グループ名の確認
        
        
        
        
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()  //AIV
        
        print("押された")
        
        
        if groupID == "" {
            alert(title: "グループIDが\n正しく入力されていません", message: "グループIDを\nもう一度入れ直してください。")
            print("error: groupID is none")
            
        }  else {
            print("ここまできた")
        
            db.collection("Group").whereField("groupID", isEqualTo: groupID).getDocuments() {(QuerySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("error: group ID not found")
                    
                    self.activityIndicatorView.stopAnimating()  //AIV
                    self.activityIndicatorView.isHidden = true
                    self.alert(title: "エラー", message: "グループが見つかりません。\nもう一度、groupIDを\n正しく入力してください。")
                } else {
                    for document in QuerySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let data = document.data()
                        let groupID = data["groupID"] as! String
                        let groupName = data["groupName"]  as! String
                        
                        self.groupUid = document.documentID
                        
                        UserDefaults.standard.set(groupName, forKey: "Enter_groupName")
                        UserDefaults.standard.set(self.groupUid, forKey: "Enter_groupUid")
                        
                        
                        print("これがデータ:\(data)")
                        print("groupID: \(groupID)")
                        print("groupName: \(groupName)")
                        print("groupUid: \(self.groupUid)")
                        
                        
                        self.activityIndicatorView.stopAnimating()  //AIV
                        self.activityIndicatorView.isHidden = true
                        print("succeed: Enter group")
                        
                        self.performSegue(withIdentifier: "go-1-8", sender: self)
                        
                    }
                }
                
            }
            
            
            
            
            
        
            //MARK: ★navigation遷移
            //        self.performSegue(withIdentifier: "ここにidentifier書く", sender: nil)
        
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
