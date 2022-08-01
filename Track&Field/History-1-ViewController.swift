//
//  History-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class History_1_ViewController: UIViewController {
    
    @IBOutlet weak var month_Label: UILabel!
    @IBOutlet weak var day_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var weather1_IV: UIImageView!
    @IBOutlet weak var weather2_IV: UIImageView!
    @IBOutlet weak var maxtemper_Label: UILabel!
    @IBOutlet weak var mintemper_Label: UILabel!
    @IBOutlet weak var today_practicetype_Label: UILabel!
    @IBOutlet weak var today_menu_Label: UILabel!
    @IBOutlet weak var today_up_distance_Label: UILabel!
    @IBOutlet weak var today_up_time_Label: UILabel!
    @IBOutlet weak var table_view_TV: UITableView!
    @IBOutlet weak var today_down_distance_Label: UILabel!
    @IBOutlet weak var today_down_time_Label: UILabel!
    @IBOutlet weak var today_total_distance_Label: UILabel!
    
    
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var parcticemene_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    
    @IBOutlet weak var practiceKind_SC: UISegmentedControl!
    
    //どのSegumentedControllが選ばれているか
    var selectedSC = "main"
    
    
    var selectedRunningData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pastView = [practiceType_picture,parcticemene_picture,up_picture,down_picture,total_picture]
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
        
//    let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
        
        //userdefault で取得・表示
        let month1: String = UserDefaults.standard.string(forKey: "recordMonth")!  //UserDefaultに変更
        month_Label.text = month1
        let day1: String = UserDefaults.standard.string(forKey: "recordDay")!  //UserDefaultに変更
        day_Label.text = day1
        
        //Firebase_String で取得・表示
        let yobi = selectedRunningData["yobi"] as! String
        date_Label.text = "(\(yobi))"
        
        
        
        
//        let max_temper = selectedRunningData["max_temper"] as! String
//        maxtemper.text = max_temper
//        let min_temper = selectedRunningData["min_temper"] as! String
//        mintemper.text = min_temper
        
        
        
        
        
        //menuBody全体を取得
        let getTodaymenuBody = selectedRunningData["menuBody"] as! [String:Any]
        
        //Firebase_Dictionary で取得・表示
        let practicetype_Dictionary = getTodaymenuBody["practiceType"] as! [String:Any] //これを参考に
        
        let menu_Dictionary = getTodaymenuBody["menu"] as! [String:Any]
        
        let upDistance_Dictionary = getTodaymenuBody["upDistance"] as! [String:Any]
        
        let upTime_Dictionary = getTodaymenuBody["upTime"] as! [String:Any]
        
        let downDistance_Dictionary = getTodaymenuBody["downDistance"] as! [String:Any]
        
        let downTime_Dictionary = getTodaymenuBody["downTime"] as! [String:Any]
        
        
        
        if practicetype_Dictionary[selectedSC] as? String == "" {
            //このタブのデータなし
            let nodata_String = "- - - -"
            
            today_practicetype_Label.text = nodata_String
            today_menu_Label.text = nodata_String
            today_up_distance_Label.text = nodata_String
            today_up_time_Label.text = nodata_String
            today_down_distance_Label.text = nodata_String
            today_down_time_Label.text = nodata_String
            
            var selectedSCJP = ""
            
            if selectedSC == "main" {
                selectedSCJP = "本練習"
            } else if selectedSC == "sub" {
                selectedSCJP = "朝練"
            } else if selectedSC == "free" {
                selectedSCJP = "自主練"
            }
            
            alert(title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
        } else {
        
            //このタブのデータあり
            
        today_practicetype_Label.text = practicetype_Dictionary[selectedSC] as? String
        today_menu_Label.text = menu_Dictionary[selectedSC] as? String
        today_up_distance_Label.text = upDistance_Dictionary[selectedSC] as? String
        today_up_time_Label.text = upTime_Dictionary[selectedSC] as? String
        today_down_distance_Label.text = downDistance_Dictionary[selectedSC] as? String
        today_down_time_Label.text = downTime_Dictionary[selectedSC] as? String
        
        
        }
        
        
        
        //MARK: これのみ例外・String取得・表示
        let totalDistance = getTodaymenuBody["totalDistance"] as! String
//        today_total_distance.text = totalDistance
        
        
        
        //SC
        practiceKind_SC.selectedSegmentTintColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0) //選択しているボタンの背景色
        practiceKind_SC.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) //選択していないボタンの背景色
        
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected) //選択しているボタンのtextColor
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)], for: .normal) //選択していないボタンのtextColor
        
    
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-2" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_2_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData3 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
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
    
    
    
    @IBAction func practiceKind_Selected(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            //朝練が選ばれた場合
            selectedSC = "sub"
            
        case 1:
            //本練が選ばれた場合
            selectedSC = "main"
            
        case 2:
            //自主練が選ばれた場合
            selectedSC = "free"
            
        default: break //break == 何もしない意
            //default値
            
        }
        
        //menuBody全体を取得
        let getTodaymenuBody = selectedRunningData["menuBody"] as! [String:Any]
        
        //Firebase_Dictionary で取得・表示
        let practicetype_Dictionary = getTodaymenuBody["practiceType"] as! [String:Any] //これを参考に
        
        let menu_Dictionary = getTodaymenuBody["menu"] as! [String:Any]
        
        let upDistance_Dictionary = getTodaymenuBody["upDistance"] as! [String:Any]
        
        let upTime_Dictionary = getTodaymenuBody["upTime"] as! [String:Any]
        
        let downDistance_Dictionary = getTodaymenuBody["downDistance"] as! [String:Any]
        
        let downTime_Dictionary = getTodaymenuBody["downTime"] as! [String:Any]
        
        
        
        if practicetype_Dictionary[selectedSC] as? String == "" {
            //このタブのデータなし
            let nodata_String = "- - - -"
            
            today_practicetype_Label.text = nodata_String
            today_menu_Label.text = nodata_String
            today_up_distance_Label.text = nodata_String
            today_up_time_Label.text = nodata_String
            today_down_distance_Label.text = nodata_String
            today_down_time_Label.text = nodata_String
            
            var selectedSCJP = ""
            
            if selectedSC == "main" {
                selectedSCJP = "本練習"
            } else if selectedSC == "sub" {
                selectedSCJP = "朝練習"
            } else if selectedSC == "free" {
                selectedSCJP = "自主練習"
            }
            
            alert(title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
        } else {
            //このタブのデータあり
            
            today_practicetype_Label.text = practicetype_Dictionary[selectedSC] as? String
            today_menu_Label.text = menu_Dictionary[selectedSC] as? String
            today_up_distance_Label.text = upDistance_Dictionary[selectedSC] as? String
            today_up_time_Label.text = upTime_Dictionary[selectedSC] as? String
            today_down_distance_Label.text = downDistance_Dictionary[selectedSC] as? String
            today_down_time_Label.text = downTime_Dictionary[selectedSC] as? String
            
        }
        
        
    }
    
    
    
    @IBAction func otherinfo() {
        self.performSegue(withIdentifier: "go-his-2", sender: selectedRunningData)
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
