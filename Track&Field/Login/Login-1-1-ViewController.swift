//
//  Login-1-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//済

import UIKit

class Login_1_1_ViewController: UIViewController {
    
    @IBOutlet weak var doLater_picture: UIImageView!
    @IBOutlet weak var newregist_picture: UIImageView!
    
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_tapped_1_1(){
        newregist_picture.image = p_nonpushed_s
        //StoryBoardで遷移設定済
    }
    @IBAction func tap(_ sender: UIButton) {
        newregist_picture.image = p_nonpushed_s
    }
    @IBAction func cancel(_ sender: UIButton) {
        newregist_picture.image = p_nonpushed_s
    }
    
    
    
    @IBAction func afterdo_1_1(){
        doLater_picture.image = p_nonpushed_s
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tap2(_ sender: UIButton) {
        doLater_picture.image = p_pushed_s
    }
    @IBAction func cancel2(_ sender: UIButton) {
        doLater_picture.image = p_nonpushed_s
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
