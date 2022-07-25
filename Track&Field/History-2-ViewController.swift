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
    
    
    @IBOutlet weak var practicePlaceType_picture: UIImageView!
    @IBOutlet weak var practicePoint_picture: UIImageView!
    @IBOutlet weak var pain_picture: UIImageView!
    @IBOutlet weak var eatTime_picture: UIImageView!
    @IBOutlet weak var sleep_picture: UIImageView!
    @IBOutlet weak var tired_picture: UIImageView!
    @IBOutlet weak var writing_picture: UIImageView!
    
    
    var selectedRunningData3:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pastView = [practicePlaceType_picture,practicePoint_picture,pain_picture,sleep_picture,eatTime_picture,writing_picture,tired_picture]
        for n in 0...pastView.count - 1 {
            let pastViewNum = pastView[n]
            pastViewNum?.layer.cornerRadius = 5
            pastViewNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            pastViewNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            pastViewNum?.layer.shadowOpacity = 0.25  //影の濃さ
            pastViewNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            pastViewNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            pastViewNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            pastViewNum?.layer.borderWidth = 1.0 // 枠線の太さ
        }

        let placeField = selectedRunningData3["placeFeild"] as! String
        today_place_feild.text = placeField
        let practicePoint = selectedRunningData3["practicePoint"] as! String
        today_point.text = practicePoint
        let painLevel = selectedRunningData3["pain_Level"] as! String
        today_pain.text = painLevel
        let eatTime = selectedRunningData3["eatTime"] as! String
        today_eat_time.text = eatTime
//        let mene = selectedRunningData["pravticeComment"] as! String
//        today_sleep.text = mene
        let tiredLevel = selectedRunningData3["tiredLevel"] as! String
        today_tired.text = tiredLevel
        let thinking = selectedRunningData3["freeWriting"] as! String
        today_detail.text = thinking
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-3" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_3_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData4 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    @IBAction func pain() {
        self.performSegue(withIdentifier: "go-his-3", sender: selectedRunningData3)
        
        
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
