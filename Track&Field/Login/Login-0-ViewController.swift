//
//  Login-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//
//なし

import UIKit

class Login_0_ViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var newregist: UIImageView!
    @IBOutlet weak var login: UIImageView!
    
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_tapped_0() {
        newregist.image = p_nonpushed_s
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        newregist.image = p_nonpushed_s
    }
    
    @IBAction func tap(_ sender: UIButton) {
        newregist.image = p_pushed_s
    }
    
    @IBAction func login_tapped(_ sender: UIButton) {
        login.image = p_nonpushed_s
    }
    
    @IBAction func tap2(_ sender: UIButton) {
        login.image = p_pushed_s
    }
    
    @IBAction func cancel2(_ sender: UIButton) {
        login.image = p_nonpushed_s
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
