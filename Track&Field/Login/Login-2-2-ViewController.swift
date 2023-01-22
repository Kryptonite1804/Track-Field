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
    @IBOutlet weak var cancel_picture: UIImageView!
    @IBOutlet weak var login_picture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {
            do {
                let userData = try await FirebaseClient.shared.getUserData()
                let username = userData.username ?? ""
                print("username: \(username)")
                self.accountname_2_2.text = username
                OtherHost.activityIndicatorView(view: view).stopAnimating()
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        accountname_2_2.layer.cornerRadius = 20
        accountname_2_2.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
        accountname_2_2.layer.borderWidth = 1.0 // 枠線の太さ
        
        OtherHost.setLabelDesign(label: accountname_2_2, cornerRadius: 20, borderColor: Asset.lineColor.color.cgColor, borderWidth: 1.0)
        
                // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        cancel_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        cancel_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func cancel_2_2() {
        cancel_picture.image = UIImage(named: "p_nonpushed_s")
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("強制ログアウト完了")
            
            //MyAlert
            //トップへ
            
            self.navigationController?.popToRootViewController(animated: true)
            OtherHost.activityIndicatorView(view: view).stopAnimating()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            OtherHost.activityIndicatorView(view: view).stopAnimating()
            print("強制ログアウト失敗")
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    
    
    @IBAction func tap2(_ sender: UIButton) {
        login_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        login_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func login_2_2() {
        login_picture.image = UIImage(named: "p_nonpushed_s")
        UserDefaults.standard.set("Register", forKey: "DefaultFrom")
        self.performSegue(withIdentifier: "go-Default", sender: nil)
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
