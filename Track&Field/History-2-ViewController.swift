//
//  History-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

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
        
//        let pastView = [practicePlaceType_picture,practicePoint_picture,pain_picture,sleep_picture,eatTime_picture,writing_picture,tired_picture]
//        for n in 0...pastView.count - 1 {
//            let pastViewNum = pastView[n]
//            pastViewNum?.layer.cornerRadius = 5
//            pastViewNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
//            pastViewNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
//            pastViewNum?.layer.shadowOpacity = 0.25  //影の濃さ
//            pastViewNum?.layer.shadowRadius = 4.0 // 影のぼかし量
//            pastViewNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
//            pastViewNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
//            pastViewNum?.layer.borderWidth = 1.0 // 枠線の太さ
//        }

        let placeType = selectedRunningData3["placeType"] as! String
        today_place_feild.text = placeType
        let practicePoint = selectedRunningData3["practicePoint"] as! String
        today_point.text = practicePoint
        
        
        //ここだけ取り方違う
        let painLevel = selectedRunningData3["pain"] as? [String: Any]
        painLevel2 = painLevel?["painTF"] as? String ?? "痛みなし"
        
        if painLevel2 == "痛みなし" {
            today_pain.text = "なし"
            today_pain.textColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)
            
        } else if painLevel2 == "痛みあり" {
            today_pain.text = "あり"
            today_pain.textColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
            
        }
        
        
        
        let mealTime = selectedRunningData3["mealTime"] as! String
        today_eat_time.text = mealTime
        let sleepStart = selectedRunningData3["sleepStart"] as! String
        today_start_sleep.text = sleepStart
        let sleepEnd = selectedRunningData3["sleepEnd"] as! String
        today_end_sleep.text = sleepEnd
        let tiredLevel = selectedRunningData3["tiredLevel"] as? String
        today_tired.text = tiredLevel
        let writing = selectedRunningData3["writing"] as! String
        today_detail.text = writing
        
        today_detail.isEditable = false
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-3" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_3_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData4 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
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
            alert(title: "この日の痛みはありません", message: "痛みがある場合、\n痛みの詳細が表示されます。")
            
        } else if painLevel2 == "痛みあり" {
            
            self.performSegue(withIdentifier: "go-his-3", sender: selectedRunningData3)
        }
        
        
        
        
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        
    let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    
//    @IBAction func back() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
