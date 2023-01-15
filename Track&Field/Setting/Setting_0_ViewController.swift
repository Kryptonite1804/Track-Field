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
        profile_picture.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
        profile_picture.layer.borderWidth = 1.0 // 枠線の太さ
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        
        
        let task = Task {
            do {
                
                let userData = try await FirebaseClient.shared.getUserData()
                let userName_String = userData.username ?? ""
                let userMode_String = userData.mode ?? ""
                
                let groupData = try await FirebaseClient.shared.getGroupData()
                    
                let groupName_String = groupData.groupName ?? ""
                self.groupID_String = groupData.groupID ?? ""
                
                username.text = userName_String
                groupname.text = groupName_String
                groupID.text = self.groupID_String
                
                if userMode_String == "player" {
                    //player用Image
                    self.userMode.image = Asset.playerPicture.image
                    
                } else if userMode_String == "coach" {
                    //coach用Image
                    self.userMode.image = Asset.coachPicture.image
                    
                }
                
                OtherHost.activityIndicatorView(view: view).stopAnimating()
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout() {
        
        let alert: UIAlertController = UIAlertController(title: "ログアウトしますか？",message: "一度ログアウトすると、\n再ログインするまで使用できません。", preferredStyle: UIAlertController.Style.alert)
        let confilmAction: UIAlertAction = UIAlertAction(title: "ログアウト", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            
            OtherHost.activityIndicatorView(view: self.view).startAnimating()
            
            let firebaseAuth = Auth.auth()
           do {
             try firebaseAuth.signOut()
               
               OtherHost.activityIndicatorView(view: self.view).stopAnimating()
               OtherHost.alertDef(view: self, title: "ログアウト完了", message: "トップページへ戻ります") { _ in
                   
                   guard let window = UIApplication.shared.keyWindow else { return }
                   let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   if window.rootViewController?.presentedViewController != nil {
                       // モーダルを開いていたら閉じてから差し替え
                       window.rootViewController?.dismiss(animated: true) {
                           window.rootViewController = storyboard.instantiateViewController(withIdentifier: "RegisterTop") as! UINavigationController
                       }
                   } else {
                       // モーダルを開いていなければそのまま差し替え
                       window.rootViewController = storyboard.instantiateViewController(withIdentifier: "RegisterTop") as! UINavigationController
                   }
               }
               
               
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            OtherHost.activityIndicatorView(view: self.view).stopAnimating()
            OtherHost.alertDef(view:self, title: "エラー", message: "ログアウトに失敗しました")
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
            
            OtherHost.activityIndicatorView(view: self.view).startAnimating()
            
            let user = Auth.auth().currentUser
            user?.delete { error in
                if error != nil {
                // An error happened.
                  
                  OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                  OtherHost.alertDef(view:self, title: "エラー", message: "アカウント削除に失敗しました")
                  
              } else {
                // Account deleted.
                  
                  OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                  
                  OtherHost.alertDef(view: self, title: "アカウント削除完了", message: "トップページへ戻ります") { _ in
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
                  }
                  
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
        OtherHost.openForm(view: self)
    }
    
    
    @IBAction func copyGroupID(_ sender: Any) {
        UIPasteboard.general.string = groupID_String
        OtherHost.alertDef(view:self, title: "コピー完了", message: "グループIDを\nクリップボードにコピーしました")
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
