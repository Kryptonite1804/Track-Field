//
//  Login-1-3-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//済

import UIKit

class Login_1_3_ViewController: UIViewController {

    @IBOutlet weak var makegroup_picture: UIImageView!
    @IBOutlet weak var joingroup_picture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        makegroup_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        makegroup_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func groupmake_1_3() {
        makegroup_picture.image = UIImage(named: "p_nonpushed_s")
        self.performSegue(withIdentifier: "go-1-4", sender: self)
    }
    
    
    @IBAction func tap2(_ sender: UIButton) {
        joingroup_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        joingroup_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func groupjoin_1_3(){
        joingroup_picture.image = UIImage(named: "p_nonpushed_s")
        self.performSegue(withIdentifier: "go-1-7", sender: self)
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
