//
//  Explain-6-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/01.
//

import UIKit

class Explain_6_ViewController: UIViewController {

    @IBOutlet weak var next_picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: UIButton) {
        next_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cancel(_ sender: UIButton) {
        next_picture.image = UIImage(named: "p_rectangle_curbed_L")
    }
    @IBAction func next_button(_ sender: UIButton) {
        next_picture.image = UIImage(named: "p_rectangle_curbed_L")
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
