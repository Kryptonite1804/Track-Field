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



class Login_1_5_ViewController: UIViewController {

    @IBOutlet weak var groupID_Label: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    var groupname: String = ""
    var groupID: String = ""
    var username: String = ""
//    var mode: String = ""
//    var dictionary: Dictionary = ["":""]
    let db = Firestore.firestore()
    var checkNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)  //AIV
        
        
        activityIndicatorView.startAnimating()  //AIV
        
        
        
        let groupIDNumber: Int = Int.random(in: 100000...999999)
        
        let groupIDLetterArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let groupIDLetter1 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupIDLetter2 = groupIDLetterArray [Int.random(in: 0...51)]
        let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
        let usernameload = UserDefaults.standard.string(forKey: "Setup_username") ?? "デフォルト値"
//        let modeload = UserDefaults.standard.string(forKey: "mode") ?? "デフォルト値"
        groupname = groupnameload
        username = usernameload
//        mode = modeload
        
        groupID = "T\(groupIDLetter1)\(groupIDLetter2)\(groupIDNumber)"
        
        groupID_Label.text = groupID
        
        
        var handle: AuthStateDidChangeListenerHandle?

        
        
        print ("groupID: \(groupID)")
        
        
        //Alert
        var alertController: UIAlertController!
        
        //Alert
        func alert(title:String, message:String) {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in

            print("Auth起動完了")
            
            
            guard let user = user else {
                print("")
                return
            }
            print("ここ")
            //ここでGroupコレクションを作成
            let ref = self.db.collection("Group")
            print("")
            
            let createduid = self.db.collection("Group").document().documentID
            print("createduid: \(createduid)")
            
            
            print("ここまで２")
            ref.document(createduid).setData( //ここでgroupのuidをランダム作成
                                                            ["groupID" : "\(self.groupID)", //groupIDを保存
                                                             "groupName" : "\(self.groupname)", //group名を保存
                                                             "membername" : ["\(self.username)"],
                                                             "memberemail": ["\(user.email as! String)"]]) //userのuidをgroupコレクションに保存
            
            
            
            print("ここまで３")
            
            
            let ref2 = self.db.collection("Users")
            
            ref2.document(user.uid).setData([  //作成済のAdultUsersコレクションのAuthのuidに...
                "groupUid" : "\(createduid)",  //上で作成したgroupのuidをuserのuidに保存
                "username" : "\(self.username)"
            ])
            
            
            { err in
                if let err = err {
                    //失敗
                    
                    self.activityIndicatorView.stopAnimating()  //AIV
                    
                    alert(title: "エラー", message: "正常にグループを作成できませんでした。")

                } else {
                    
                    //成功
                    print("succeed")
                    self.checkNumber = 1
                    Auth.auth().removeStateDidChangeListener(handle!)
                    self.activityIndicatorView.stopAnimating()  //AIV
                    
                }
            }
        }
        
        groupID_Label.layer.cornerRadius = 20
        groupID_Label.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        groupID_Label.layer.borderWidth = 1.0 // 枠線の太さ
        
        }
    
    @IBAction func next_1_5() {
        
            if checkNumber == 1 {
                self.performSegue(withIdentifier: "go-1-6", sender: self)
            } else {
                //失敗している
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
