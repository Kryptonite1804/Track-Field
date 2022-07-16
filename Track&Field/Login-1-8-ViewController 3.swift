//
//  Login-1-8-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Login_1_8_ViewController: UIViewController {

    @IBOutlet weak var groupID_1_8: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_1_8() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func groupjoin_1_8() {
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
