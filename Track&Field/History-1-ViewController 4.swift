//
//  History-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class History_1_ViewController: UIViewController {
    
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weather1: UIImageView!
    @IBOutlet weak var weather2: UIImageView!
    @IBOutlet weak var maxtemper: UILabel!
    @IBOutlet weak var mintemper: UILabel!
    @IBOutlet weak var today_practicetype: UILabel!
    @IBOutlet weak var today_mene: UILabel!
    @IBOutlet weak var today_up_distance: UILabel!
    @IBOutlet weak var todat_up_time: UILabel!
    
    /*
    @IBOutlet weak var main_mene_number: UILabel!
    @IBOutlet weak var main_mene_distance: UITextField!
    @IBOutlet weak var main_mene_time: UILabel!
     */
    
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var main_mene_pace: UILabel!
    @IBOutlet weak var today_down_distance: UILabel!
    @IBOutlet weak var today_down_time: UILabel!
    @IBOutlet weak var today_total_distance: UILabel!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func otherinfo() {
        self.performSegue(withIdentifier: "go-his-2", sender: self)
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
