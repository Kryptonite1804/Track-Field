//
//  Record_3_ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/08/30.
//

import UIKit

class Record_3_ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func edit() {
        
        self.navigationController?.popToRootViewController(animated: true)
        
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
