//
//  History-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//なし

import UIKit
import SafariServices

class History_2_ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var today_place_feild: UILabel!
    @IBOutlet weak var today_point: UILabel!
    @IBOutlet weak var today_pain: UILabel!
    @IBOutlet weak var today_eat_time: UILabel!
    @IBOutlet weak var today_end_sleep: UILabel!
    @IBOutlet weak var today_start_sleep: UILabel!
    @IBOutlet weak var today_tired: UILabel!
    @IBOutlet weak var today_detail: UITextView!
    
    @IBOutlet weak var practicePlaceType_picture: UIImageView!
    @IBOutlet weak var practicePoint_picture: UIImageView!
    @IBOutlet weak var pain_picture: UIImageView!
    @IBOutlet weak var eatTime_picture: UIImageView!
    @IBOutlet weak var sleep_picture: UIImageView!
    @IBOutlet weak var tired_picture: UIImageView!
    @IBOutlet weak var writing_picture: UIImageView!
    
    var painLevel2 = ""
    
    var selectedRunningData3:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        today_place_feild.text = selectedRunningData3["placeType"] as? String ?? ""
        today_point.text = selectedRunningData3["practicePoint"] as? String ?? ""
        
        //ここだけ取り方違う
        let painLevel = selectedRunningData3["pain"] as? [String: Any]
        painLevel2 = painLevel?["painTF"] as? String ?? "痛みなし"
        
        if painLevel2 == "痛みなし" {
            today_pain.text = "なし"
            today_pain.textColor = Asset.mainColor.color
            
        } else if painLevel2 == "痛みあり" {
            today_pain.text = "あり"
            today_pain.textColor = Asset.subRedColor.color
        }
        
        let keyArray = ["mealTime","sleepStart","sleepEnd","tiredLevel","writing"]
        let uiArray = [today_eat_time,today_start_sleep,today_end_sleep,today_tired,today_detail]
        for n in 0...keyArray.count {
            let ui = uiArray[n] as? UILabel
            ui?.text = selectedRunningData3[keyArray[n]] as? String ?? ""
        }
        
        today_detail.isEditable = false
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-3" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_3_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData4 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    @IBAction func tap(_ sender: UIButton) {
        pain_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        pain_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func pain() {
        pain_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        if painLevel2 == "痛みなし" {
            AlertHost.alertDef(view: self, title: "この日の痛みはありません", message: "痛みがある場合、\n痛みの詳細が表示されます。")
            
        } else if painLevel2 == "痛みあり" {
            self.performSegue(withIdentifier: "go-his-3", sender: selectedRunningData3)
        }
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
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
