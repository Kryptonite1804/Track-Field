//
//  Analize-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit

class Analize_0_ViewController: UIViewController {

    @IBOutlet weak var startday_check: UIImageView!
    @IBOutlet weak var endday_check: UIImageView!
    @IBOutlet weak var graph_key1_check: UIImageView!
    @IBOutlet weak var graph_key2_check: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func graph_key1() {
    }
    
    @IBAction func graph_key2() {
    }
    
    @IBAction func startay() {
    }
    
    @IBAction func endday() {
    }
    
    @IBAction func make_graph() {
        //グラフの日付・要素確認
        
        self.performSegue(withIdentifier: "go-ana_1", sender: self)
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
