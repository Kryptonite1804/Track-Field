//
//  Explain-7-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/01.
//
//なし

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Explain_7_ViewController: UIViewController {
    
    @IBOutlet weak var usenow_picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {
            do {
                
                let userData = try await FirebaseClient.shared.getUserData()
                let userMode_String = userData.mode
                print("mode: \(userMode_String ?? "none - userData.mode")")
                
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
