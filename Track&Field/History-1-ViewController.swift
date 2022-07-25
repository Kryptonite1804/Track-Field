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
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var today_down_distance: UILabel!
    @IBOutlet weak var today_down_time: UILabel!
    @IBOutlet weak var today_total_distance: UILabel!
    
    
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var parcticemene_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    
    
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
        
        let month1 = selectedRunningData["month"] as! String
        month.text = month1

        let yobi = selectedRunningData["yobi"] as! String
        date.text = yobi
        let max_temper = selectedRunningData["max_temper"] as! String
        maxtemper.text = max_temper
        let min_temper = selectedRunningData["min_temper"] as! String
        mintemper.text = min_temper
        let placeType = selectedRunningData["placeType"] as! String
        today_practicetype.text = placeType
        let mene = selectedRunningData["pravticeComment"] as! String
        today_mene.text = mene
        let upDistance = selectedRunningData["up_Distance"] as! String
        today_up_distance.text = upDistance
        let upTime = selectedRunningData["up_Time"] as! String
        todat_up_time.text = upTime
        let downDictance = selectedRunningData["down_Dictance"] as! String
        today_down_distance.text = downDictance
        let downTime = selectedRunningData["down_Time"] as! String
        today_down_time.text = downTime
        let totalDistance = selectedRunningData["total_dictance"] as! String
        today_total_distance.text = totalDistance
    
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func otherinfo() {
        self.performSegue(withIdentifier: "go-his-2", sender: selectedRunningData)
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
            if segue.identifier == "go-his-2" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
                let nextVC = segue.destination as! History_2_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
                nextVC.selectedRunningData3 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
            }
        }
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
