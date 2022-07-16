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
    @IBOutlet weak var today_down_distance: UILabel!
    @IBOutlet weak var today_down_time: UILabel!
    @IBOutlet weak var today_total_distance: UILabel!
    
    
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var parcticemene_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pastView = [practiceType_picture,parcticemene_picture,pain_picture,up_picture,down_picture,total_picture]
        let pastViewCount = pastView.count
        for n in 0...pastViewCount-1 {
            let pastViewNum = pastView[n]
            pastViewNum.layer.cornerRadius = 5
            pastViewNum.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            pastViewNum.layer.shadowColor = UIColor.black.cgColor //　影の色
            pastViewNum.layer.shadowOpacity = 0.25  //影の濃さ
            pastViewNum.layer.shadowRadius = 4.0 // 影のぼかし量
            pastViewNum.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            pastViewNum.layer.borderColor = UIColor(red: 174, green: 55, blue: 247, alpha: 0.75).cgColor  // 枠線の色
            pastViewNum.layer.borderWidth = 1.0 // 枠線の太さ
        }
        
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
