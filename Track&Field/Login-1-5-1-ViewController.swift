//
//  Login-1-5-1-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/19.
//

import UIKit
import UserNotifications

class Login_1_5_1_ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
        // Do any additional setup after loading the view.
    }
    
    
    
    
    

    @IBAction func gonext() {
        
        //通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted{
                    UNUserNotificationCenter.current().delegate = self
                }
            }
        
        
        self.performSegue(withIdentifier: "go-1-6", sender: self)
        
        
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
