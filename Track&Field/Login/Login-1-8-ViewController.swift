//
//  Login-1-8-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//MARK: 残保存

import UIKit
import Firebase
import FirebaseFirestore

class Login_1_8_ViewController: UIViewController {
    
    @IBOutlet weak var groupID_1_8: UILabel!
    @IBOutlet weak var cancel_picture: UIImageView!
    @IBOutlet weak var join_picture: UIImageView!
    
    var groupName :String = ""
    var groupUid :String = ""
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
        
        OtherHost.setLabelDesign(label: groupID_1_8, cornerRadius: 20, borderColor: Asset.lineColor.color.cgColor, borderWidth: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        cancel_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        cancel_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func cancel_1_8() {
        cancel_picture.image = UIImage(named: "p_nonpushed_s")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func tap2(_ sender: UIButton) {
        join_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        join_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func groupjoin_1_8() {
        join_picture.image = UIImage(named: "p_nonpushed_s")
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {
            do {
                
                let userUid = try await FirebaseClient.shared.getUUID()
                let groupData =  try await FirebaseClient.shared.getGroupData()
                var member = groupData.member ?? [[:]]
                
                print("member_Array: \(member)")
                
                let dictionary = ["username": self.username, "mode": self.mode, "userUid": userUid]
                member.append(dictionary)
                
                
                let ref = self.db.collection("Group")
                try await ref.document(self.groupUid).updateData(
                    ["member" : member]
                )
                
                //ここから
                let ref3 = self.db.collection("Users")
                try await ref3.document(userUid).setData(
                    ["groupUid" : self.groupUid,
                     "username" : self.username,
                     "mode" : self.mode])
                
                //成功
                print("succeed22")
                OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                UserDefaults.standard.set("Register", forKey: "DefaultFrom")
                self.performSegue(withIdentifier: "go-Default", sender: self)
                
                
            }
            catch {
                print(error.localizedDescription)
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
