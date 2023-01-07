//
//  Explain-7-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/01.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Explain_7_ViewController: UIViewController {
    
    @IBOutlet weak var usenow_picture: UIImageView!
//    let db = Firestore.firestore()
    var activityIndicatorView = UIActivityIndicatorView()
    
//    var userUid: String = ""
//    var groupUid: String = ""
//
//    var userMode_String: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        usenow_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cancel(_ sender: UIButton) {
        usenow_picture.image = UIImage(named: "p_rectangle_curbed_L")
    }
    @IBAction func usenow_1_6() {
        usenow_picture.image = UIImage(named: "p_rectangle_curbed_L")
        activityIndicatorView.startAnimating()
        
        
        
        let task = Task {
            do {
//                self.userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
                
                
                //Adultusersコレクション内の情報を取得
//                let docRef2 = self.db.collection("Users").document("\(self.userUid)")
//
//                docRef2.getDocument { (document, error) in
//                    if let document = document, document.exists {
//
//
//                        let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data2: \(documentdata2)")
//
//
//                        self.groupUid = document.data()!["groupUid"] as! String
//                        print("groupUid: ",self.groupUid)
//
//                        self.userMode_String = document.data()!["mode"] as! String
//                        print("mode: ",self.userMode_String)
                        
                let userData = try await FirebaseClient.shared.getUserData()
                let userMode_String = userData.mode
                print("mode: \(userMode_String ?? "none - userData.mode")")
                
                self.activityIndicatorView.stopAnimating()
                
                if userMode_String == "player" {
                    
                    self.performSegue(withIdentifier: "toHomeP", sender: nil)
                    
                } else if userMode_String == "coach" {
                    
                    self.performSegue(withIdentifier: "toHomeC", sender: nil)
                    
                }
                
                        
                        
                        
                        
//                    }
//                }
                
             
                
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
