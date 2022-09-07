//
//  Setting_0_ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Setting_0_ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var profile_picture: UIImageView! //コーチか選手か
    @IBOutlet weak var groupMumber_picture: UIImageView!
    @IBOutlet weak var defultSetting_picture: UIImageView!
    @IBOutlet weak var logout_picture: UIImageView!
    @IBOutlet weak var accountDelete_picture: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var groupname: UILabel!
    @IBOutlet weak var groupID: UILabel!
    
    @IBOutlet weak var userMode: UIImageView!
    
    let db = Firestore.firestore()
    var activityIndicatorView = UIActivityIndicatorView()
    
    var userUid: String = ""
    var groupUid: String = ""
    
    var userName_String: String = ""
    var userMode_String: String = ""
    var groupName_String: String = ""
    var groupID_String: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let picture = [defultSetting_picture,groupMumber_picture]
//        for n in 0...picture.count - 1 {
//            let pictureNum = picture[n]
//            pictureNum?.layer.cornerRadius = 30
//            pictureNum?.backgroundColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 1.0)//塗り潰し
//            pictureNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
//            pictureNum?.layer.shadowOpacity = 0.25  //影の濃さ
//            pictureNum?.layer.shadowRadius = 4.0 // 影のぼかし量
//            pictureNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
//            pictureNum?.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor  // 枠線の色
//            pictureNum?.layer.borderWidth = 1.0 // 枠線の太さ
//        }
//
//        let picture2 = [logout_picture,accountDelete_picture]
//        for n in 0...picture2.count - 1 {
//            let pictureNum = picture2[n]
//            pictureNum?.layer.cornerRadius = 30
//            pictureNum?.backgroundColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)//塗り潰し
//            pictureNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
//            pictureNum?.layer.shadowOpacity = 0.25  //影の濃さ
//            pictureNum?.layer.shadowRadius = 4.0 // 影のぼかし量
//            pictureNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
//            pictureNum?.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor  // 枠線の色
//            pictureNum?.layer.borderWidth = 1.0 // 枠線の太さ
//        }
        
        
        profile_picture.layer.cornerRadius = 5
        profile_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        profile_picture.layer.borderWidth = 1.0 // 枠線の太さ
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
        
        
        activityIndicatorView.startAnimating()
        
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in

            guard let user = user else {

                return
            }

            self.userUid = user.uid


            //Adultusersコレクション内の情報を取得
            let docRef2 = self.db.collection("Users").document("\(self.userUid)")

            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data2: \(documentdata2)")


                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)
                    
                    self.userName_String = document.data()!["username"] as! String
                    print("username: ",self.userName_String)
                    
                    self.userMode_String = document.data()!["mode"] as! String
                    print("mode: ",self.userMode_String)

                    UserDefaults.standard.set(self.groupUid, forKey: "groupUid")
                    UserDefaults.standard.set(self.userUid, forKey: "userUid")
                    
                    
                    
                    
                    
                    
                    
                    let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef3.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")
                            
                                //全て成功
                            
                            self.groupName_String = document.data()!["groupName"] as! String
                            print("groupName: ",self.groupName_String)
                            self.groupID_String = document.data()!["groupID"] as! String
                            print("groupID: ",self.groupID_String)
                            
                            
                            self.username.text = self.userName_String
                            self.groupname.text = self.groupName_String
                            self.groupID.text = self.groupID_String
                            
                            if self.userMode_String == "player" {
                                
                                //player用Image
                                self.userMode.image = UIImage(named: "player_picture")!
                                
                                
                                
                            } else if self.userMode_String == "coach" {
                                
                                //coach用Image
                                self.userMode.image = UIImage(named: "coach_picture")!
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                    
                        } else {
                            print("Document3 does not exist")
                            print("練習記録なし")
                            self.activityIndicatorView.stopAnimating()  //AIV
                            
//                            self.alert(title: "練習記録がありません", message: "まだ今日の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                            
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                } else {
                    print("Document2 does not exist")

                    self.activityIndicatorView.stopAnimating()  //AIV
//                    self.alert(title: "エラー", message: "各種情報の取得に失敗しました。")
                }
            }

        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert2(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    @IBAction func logout() {
        
        let alert: UIAlertController = UIAlertController(title: "ログアウトしますか？",message: "一度ログアウトすると、\n再ログインするまで使用できません。", preferredStyle: UIAlertController.Style.alert)
        let confilmAction: UIAlertAction = UIAlertAction(title: "ログアウト", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            
            
            self.activityIndicatorView.startAnimating()
            
            let firebaseAuth = Auth.auth()
           do {
             try firebaseAuth.signOut()
            
            
               
               
               
               let alert3: UIAlertController = UIAlertController(title: "ログアウト完了",message: "ログアウト処理が完了しました。\nトップページへ戻ります。", preferredStyle: UIAlertController.Style.alert)
               let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                   (action: UIAlertAction!) -> Void in
                   
                   
                   guard let window = UIApplication.shared.keyWindow else { return }
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   if window.rootViewController?.presentedViewController != nil {
                       // モーダルを開いていたら閉じてから差し替え
                       window.rootViewController?.dismiss(animated: true) {
                           window.rootViewController = storyboard.instantiateInitialViewController()
                       }
                   } else {
                       // モーダルを開いていなければそのまま差し替え
                       window.rootViewController = storyboard.instantiateInitialViewController()
                   }
                   
                   
               })
               
               alert3.addAction(confilmAction)
               
               self.activityIndicatorView.stopAnimating()
               //alertを表示
               self.present(alert3, animated: true, completion: nil)
               
               
               
               
            
            
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            self.activityIndicatorView.stopAnimating()
            self.alert2(title: "エラー", message: "ログアウトに失敗しました")
        }
            
            
            
            
            
            
            
            
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil)
        
        alert.addAction(confilmAction)
        alert.addAction(cancelAction)
        
        //alertを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func deleteAccount() {
        
        let alert: UIAlertController = UIAlertController(title: "アカウント削除しますか？",message: "アカウントを削除すると、再度ログインするまでアプリを利用できません。", preferredStyle: UIAlertController.Style.alert)
        let confilmAction: UIAlertAction = UIAlertAction(title: "アカウント削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) -> Void in
            
            
            
            
            
            
            
            self.activityIndicatorView.startAnimating()
            
            let user = Auth.auth().currentUser

            user?.delete { error in
              if let error = error {
                // An error happened.
                  
                  self.activityIndicatorView.stopAnimating()
                  self.alert2(title: "エラー", message: "アカウント削除に失敗しました")
                  
                  
                  
              } else {
                // Account deleted.
                  
                  //MyAlert
                  //dismissdismiss
                  
                  let alert: UIAlertController = UIAlertController(title: "アカウント削除完了",message: "アカウント削除処理が完了しました。\nトップページへ戻ります。", preferredStyle: UIAlertController.Style.alert)
                  let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                      (action: UIAlertAction!) -> Void in
                      
                      
                      guard let window = UIApplication.shared.keyWindow else { return }
                      let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      if window.rootViewController?.presentedViewController != nil {
                          // モーダルを開いていたら閉じてから差し替え
                          window.rootViewController?.dismiss(animated: true) {
                              window.rootViewController = storyboard.instantiateInitialViewController()
                          }
                      } else {
                          // モーダルを開いていなければそのまま差し替え
                          window.rootViewController = storyboard.instantiateInitialViewController()
                      }
                      
                      
                  })
                  
                  alert.addAction(confilmAction)
                  self.activityIndicatorView.stopAnimating()
                  //alertを表示
                  self.present(alert, animated: true, completion: nil)
                  
              }
            }
                        
                        
            
            
            
            
            
            
            
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:nil)
        
        alert.addAction(confilmAction)
        alert.addAction(cancelAction)
        
        //alertを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func goForm(_ sender: Any) {
        
    let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
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
