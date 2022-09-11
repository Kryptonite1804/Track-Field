//
//  Login-1-6-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Login_1_6_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func viewhowuse_1_6() {
        
    }
    
    @IBAction func usenow_1_6() {
        
        
        let modeload = UserDefaults.standard.string(forKey: "Setup_mode") ?? "デフォルト値"
        
        if modeload == "player" {
            
            performSegue(withIdentifier: "toHomeP", sender: nil)
            
        } else if modeload == "coach" {
            
            performSegue(withIdentifier: "toHomeC", sender: nil)
            
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
