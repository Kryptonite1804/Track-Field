//
//  Record-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit

class Record_0_ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weather1: UIImageView!
    @IBOutlet weak var weather2: UIImageView!
    @IBOutlet weak var maxtemper: UILabel!
    @IBOutlet weak var mintemper: UILabel!
    
    @IBOutlet weak var practice_mene_check: UIImageView!
    @IBOutlet weak var place_feild_check: UIImageView!
    @IBOutlet weak var point_check: UIImageView!
    @IBOutlet weak var pain_check: UIImageView!
    @IBOutlet weak var eat_time_check: UIImageView!
    @IBOutlet weak var sleep_check: UIImageView!
    @IBOutlet weak var tired_check: UIImageView!
    @IBOutlet weak var writinng_check: UIImageView!
    
    @IBOutlet weak var practicemene_picture: UIImageView!
    @IBOutlet weak var placefeild_picture: UIImageView!
    @IBOutlet weak var point_picture: UIImageView!
    @IBOutlet weak var pain_pisture: UIImageView!
    @IBOutlet weak var eatTime_picture: UIImageView!
    @IBOutlet weak var sleep_picture: UIImageView!
    @IBOutlet weak var tired_picture: UIImageView!
    @IBOutlet weak var writing_picture: UIImageView!
    
    
    @IBOutlet weak var writing: UITextView!
    
    @IBOutlet weak var placeTypeButton: UIButton!
    @IBOutlet weak var practicePonitButton: UIButton!
    @IBOutlet weak var mealTimeButton: UIButton!
    @IBOutlet weak var sleepStartButton: UIButton!
    @IBOutlet weak var sleepEndButton: UIButton!
    @IBOutlet weak var tiredRevelButton: UIButton!
    
    
    
    let createdDate_Formatter = DateFormatter()  //DP
    var createdDate: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    
    var aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date
        let today = Date()
        createdDate_Formatter.dateFormat = "yyyy/MM/dd/E"//2022/07/12/日 履歴のための現在日時の取得
        createdDate = createdDate_Formatter.string(from: today)
        createdDate_Formatter.dateFormat = "M"
        todayMonth = createdDate_Formatter.string(from: today)
        createdDate_Formatter.dateFormat = "d"
        todayDay = createdDate_Formatter.string(from: today)
        createdDate_Formatter.dateFormat = "E"
        todayYobi = createdDate_Formatter.string(from: today)
        
        let intMonth: Int = Int(todayMonth)!
        let intDay: Int = Int(todayDay)!
        
        if intMonth > 9  {
            month.text = todayMonth
        } else  {
            month.text = "0\(todayMonth)"
        }
        
        if intDay > 9  {
            day.text = todayDay
        } else  {
            day.text = "0\(todayDay)"
        }
        
        date.text = "(\(todayYobi))"
        
        print("日時デフォルト値: \(createdDate)")
        print("月:",month.text)
        print("日:",day.text)
        print("曜日:",date.text)

        
        //design
        let recordMain = [practicemene_picture,placefeild_picture,point_picture,pain_pisture,eatTime_picture,sleep_picture,tired_picture,writing_picture]
        
        for n in 0...recordMain.count - 1 {
            let recordMainNum = recordMain[n]
            recordMainNum?.layer.cornerRadius = 20
            recordMainNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            recordMainNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            recordMainNum?.layer.shadowOpacity = 0.25  //影の濃さ
            recordMainNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            recordMainNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func practice_record() {
        
        self.performSegue(withIdentifier: "go-record-1", sender: self)
        
    }
    
    @IBAction func place_field_record() {
        
    }
    
    @IBAction func point_record() {
        
    }
    
    @IBAction func pain_record() {
        self.performSegue(withIdentifier: "go-record-2", sender: self)
    }
    
    @IBAction func eat_time_record() {
        
    }
    
    @IBAction func sleep_start_record() {
        
    }
    
    @IBAction func sleep_end_record() {
        
    }
    
    @IBAction func tired_record() {
        
    }
    
    @IBAction func register() {
        
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
