//
//  Login-1-8-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import Firebase
import FirebaseFirestore

class Login_1_8_ViewController: UIViewController {

    @IBOutlet weak var groupID_1_8: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()  //AIV
    
    var groupName :String = ""
    var groupUid :String = ""
    var userUid :String = ""
    var useremail :String = ""
    var username :String = ""
    var mode :String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
        
        self.groupName = UserDefaults.standard.string(forKey: "Enter_groupName") ?? "デフォルト値"
        
        self.groupUid = UserDefaults.standard.string(forKey: "Enter_groupUid") ?? "デフォルト値"
        self.username = UserDefaults.standard.string(forKey: "Setup_username") ?? "デフォルト値"
        self.mode = UserDefaults.standard.string(forKey: "Setup_mode") ?? "デフォルト値"
        
        
        
        groupID_1_8.text = groupName
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        groupID_1_8.layer.cornerRadius = 20
        groupID_1_8.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        groupID_1_8.layer.borderWidth = 1.0 // 枠線の太さ
        
        // Do any additional setup after loading the view.
    }
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    @IBAction func cancel_1_8() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func groupjoin_1_8() {
        
        
            
            activityIndicatorView.startAnimating()  //AIV
            
            Auth.auth().addStateDidChangeListener{ (auth, user) in

                guard let user = user else {
                    
                    return
                }
                
                print("ここ！！！！")
                print(user.uid)
                
                self.userUid = user.uid
                self.useremail = user.email!
                
                //Adultusersコレクション内の情報を取得
                        
                        
                        let docRef2 = self.db.collection("Group").document("\(self.groupUid)")

                        docRef2.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                                print("Document data2: \(documentdata2)")
                                
                                
                                var member = document.data()!["member"] as? Array<Any> ?? []
                                
                                print("member: \(member)")
                                
                                
                                print("member_Array: \(member)")
                                
                                let dictionary = ["username": self.username, "mode": self.mode, "userUid": user.uid]
                                
                                member.append(dictionary)
                                
                                
                        let ref = self.db.collection("Group")
                                ref.document(self.groupUid).updateData( //ここでgroupのuidをランダム作成
                                    ["member" : member]
                                )
                                
                        { err in
                            if let err = err {
                                //失敗

                            } else {
                                //成功
                                print("succeed")
                                
                                //ここから
                                let ref3 = self.db.collection("Users")
                                ref3.document(self.userUid).setData( 
                                            ["groupUid" : self.groupUid,
                                             "username" : self.username,
                                             "mode" : self.mode])
                                
                                
                                { err in
                                    if let err = err {
                                        //失敗
                                        print("失敗")
                                        

                                    } else {
                                        
                                        //成功
                                        print("succeed22")
                                        self.activityIndicatorView.stopAnimating()  //AIV
                                        UserDefaults.standard.set("Register", forKey: "DefaultFrom")
                                        self.performSegue(withIdentifier: "go-Default", sender: self)
                                        
                                    }
                                }
                                //ここから
                                
                            }
                        }
                        
                            } else {
                                print("Document does not exist")
                                
                                
                                //MyAlert
                                //poptoroot
                                let alert: UIAlertController = UIAlertController(title: "エラー",message: "エラーが発生しました。\nログインし直してください。", preferredStyle: UIAlertController.Style.alert)
                                let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                                    (action: UIAlertAction!) -> Void in
                                    
                                    self.navigationController?.popToRootViewController(animated: true)
                                    
                                })
                                
                                alert.addAction(confilmAction)
                                
                                self.activityIndicatorView.stopAnimating()
                                //alertを表示
                                self.present(alert, animated: true, completion: nil)
                                
                                
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
