//
//  Login-1-5-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//


import UIKit
import Firebase //FB
import FirebaseAuth
import FirebaseFirestore

import Foundation
import Combine



class Login_1_5_ViewController: UIViewController {
    
    @IBOutlet weak var groupID_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    var groupname: String = ""
    var groupID: String = ""
    var username: String = ""
    var mode: String = ""
    var dictionary: Dictionary = ["":""]
    let db = Firestore.firestore()
    var checkNumber: Int = 0
    
    @IBOutlet weak var next_picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        OtherHost.setLabelDesign(label: groupID_Label, cornerRadius: 20, borderColor: Asset.lineColor.color.cgColor, borderWidth: 1.0)
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let groupIDNumber: Int = Int.random(in: 100000...999999)
        
        let groupIDLetterArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let groupIDLetter1 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupIDLetter2 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
        let usernameload = UserDefaults.standard.string(forKey: "Setup_username") ?? "デフォルト値"
        let modeload = UserDefaults.standard.string(forKey: "Setup_mode") ?? "デフォルト値"
        
        groupname = groupnameload
        username = usernameload
        mode = modeload
        
        groupID = "T\(groupIDLetter1)\(groupIDLetter2)\(groupIDNumber)"
        print ("groupID: \(groupID)")
        groupID_Label.text = groupID
        
        let task = Task {
            do {
                let userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
                //ここでGroupコレクションを作成
                let ref = self.db.collection("Group")
                self.dictionary = ["username": self.username, "mode": self.mode, "userUid": userUid]
                
                let createduid = ref.document().documentID
                print("createduid: \(createduid)")
                
                try await ref.document(createduid).setData( //ここでgroupのuidをランダム作成
                    ["groupID" : "\(self.groupID)", //groupIDを保存
                     "groupName" : "\(self.groupname)", //group名を保存
                     "member" : [self.dictionary]]) //userのuidをgroupコレクションに保存
                
                try await self.db.collection("Users").document(userUid).setData(  //作成済AdultUsersCollectionのAuthUIDに…
                    ["groupUid" : "\(createduid)",  //上で作成したgroupのuidをuserのuidに保存
                     "username" : "\(self.username)",
                     "mode" : "\(self.mode)"])
                
                //成功
                self.checkNumber = 1
                OtherHost.activityIndicatorView(view: view).stopAnimating()
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    @IBAction func tap(_ sender: UIButton) {
        next_picture.image = UIImage(named: "p_pushed_s")
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        next_picture.image = UIImage(named: "p_nonpushed_s")
    }
    
    @IBAction func next_1_5() {
        next_picture.image = UIImage(named: "p_nonpushed_s")
        if checkNumber == 1 {
            UserDefaults.standard.set("Register", forKey: "DefaultFrom")
            self.performSegue(withIdentifier: "go-Default", sender: self)
        } else { /*失敗している*/ }
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
