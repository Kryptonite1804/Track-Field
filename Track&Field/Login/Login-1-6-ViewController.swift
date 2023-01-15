//
//  Login-1-6-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//TODO: 要動作確認 -> コメントアウト部削除

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Login_1_6_ViewController: UIViewController {
    
    @IBOutlet weak var showuse_picture: UIImageView!
    @IBOutlet weak var nowuse_picture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        showuse_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cancel(_ sender: UIButton) {
        showuse_picture.image = UIImage(named: "p_rectangle_curbed_L")
    }
    @IBAction func viewhowuse_1_6() {
        showuse_picture.image = UIImage(named: "p_rectangle_curbed_L")
    }
    
    
    @IBAction func tap2(_ sender: UIButton) {
        nowuse_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        nowuse_picture.image = UIImage(named: "p_rectangle_curbed_L")
    }
    @IBAction func usenow_1_6() {
        nowuse_picture.image = UIImage(named: "p_rectangle_curbed_L")
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {  //Task Class
            do {
                
                let userData = try await FirebaseClient.shared.getUserData()
                let userMode_String = userData.mode
                print("mode: \(userMode_String ?? "userMode_String")")
                OtherHost.activityIndicatorView(view: view).stopAnimating()
                
                if userMode_String == "player" {
                    self.performSegue(withIdentifier: "toHomeP", sender: nil)
                    
                } else if userMode_String == "coach" {
                    self.performSegue(withIdentifier: "toHomeC", sender: nil)
                }
                
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
