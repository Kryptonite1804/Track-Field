//
//  Explain-7-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/01.
//

import UIKit

class Explain_7_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func usenow_1_6() {
        
        performSegue(withIdentifier: "toHome", sender: nil)
        
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
