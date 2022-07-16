//
//  History-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class History_2_ViewController: UIViewController {

    @IBOutlet weak var today_place_feild: UILabel!
    @IBOutlet weak var today_point: UILabel!
    @IBOutlet weak var today_pain: UILabel!
    @IBOutlet weak var today_eat_time: UILabel!
    @IBOutlet weak var today_sleep: UILabel!
    @IBOutlet weak var today_tired: UILabel!
    @IBOutlet weak var today_detail: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pain() {
        self.performSegue(withIdentifier: "go-his-3", sender: self)
    }
    
    @IBAction func back() {
        self.navigationController?.popViewController(animated: true)
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
