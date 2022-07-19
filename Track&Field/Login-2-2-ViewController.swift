//
//  Login-2-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Login_2_2_ViewController: UIViewController {
    
    @IBOutlet weak var accountname_2_2: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
        activityIndicatorView.startAnimating()  //AIV
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in

            guard let user = user else {
                
                return
            }
            
            self.userUid = user.uid
            
            /*
            self.db.collection("Users").document(self.userUid).getDocument { (document, error) in
                
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing: ))
                    print("ここまで来ました")
                    print(dataDescription)
                }
                */
            
            
            print("ここまで①")
            print(self.userUid)
            
            
            //Usersコレクション内の情報を取得
            let docRef1 = self.db.collection("Users").document("\(self.userUid)")
            
            docRef1.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata1 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data1: \(documentdata1)")
                    
                    self.username = document.data()!["username"] as! String
                    print("username: ",self.username)
                    
                    self.accountname_2_2.text = self.username
                    self.activityIndicatorView.stopAnimating()
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
        
        accountname_2_2.layer.cornerRadius = 20
        accountname_2_2.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        accountname_2_2.layer.borderWidth = 1.0 // 枠線の太さ
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_2_2() {
        
        
            activityIndicatorView.startAnimating()
            
            let firebaseAuth = Auth.auth()
           do {
             try firebaseAuth.signOut()
               
               print("強制ログアウト完了")
               
               //MyAlert
               //トップへ
               
               self.navigationController?.popToRootViewController(animated: true)
                   
               activityIndicatorView.stopAnimating()
               
               
           } catch let signOutError as NSError {
             print("Error signing out: %@", signOutError)
               activityIndicatorView.stopAnimating()
               print("強制ログアウト失敗")
               
               self.navigationController?.popToRootViewController(animated: true)
           }
        
        
        
        
        
        
    }
    
    @IBAction func login_2_2() {
        self.performSegue(withIdentifier: "go-1-6", sender: nil)
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
