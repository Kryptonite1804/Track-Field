//
//  Login-1-2-1-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/07/16.
//
//なし

import UIKit

class Login_1_2_1_ViewController: UIViewController {
    
    @IBOutlet weak var coach_picture: UIImageView!
    @IBOutlet weak var player_tictre: UIImageView!
    
    var p_nonpushed_s = Asset.pNonpushedS.image
    var p_pushed_s = Asset.pPushedS.image
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: UIButton) {
        player_tictre.image = p_pushed_s
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        player_tictre.image = p_nonpushed_s
    }
    
    @IBAction func tap_player() {
        player_tictre.image = p_nonpushed_s
        UserDefaults.standard.set("player", forKey: "Setup_mode")
        self.performSegue(withIdentifier: "go-1-3", sender: self)
    }
    
    @IBAction func tap2(_ sender: UIButton) {
        coach_picture.image = p_pushed_s
    }
    
    @IBAction func cancel2(_ sender: UIButton) {
        coach_picture.image = p_nonpushed_s
    }
    
    @IBAction func tap_coach(){
        coach_picture.image = p_nonpushed_s
        UserDefaults.standard.set("coach", forKey: "Setup_mode")
        self.performSegue(withIdentifier: "go-1-3", sender: self)
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
