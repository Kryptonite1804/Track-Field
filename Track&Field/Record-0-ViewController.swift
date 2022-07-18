//
//  Record-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit

class Record_0_ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

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
    @IBOutlet weak var writing_check: UIImageView!
    
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
    @IBOutlet weak var practicePointButton: UIButton!
    @IBOutlet weak var mealTimeButton: UIButton!
    @IBOutlet weak var sleepStartButton: UIButton!
    @IBOutlet weak var sleepEndButton: UIButton!
    @IBOutlet weak var tiredRevelButton: UIButton!
    
    @IBOutlet weak var placeType_TF: UITextField!
    @IBOutlet weak var practicePoint_TF: UITextField!
    @IBOutlet weak var mealTime_TF: UITextField!
    @IBOutlet weak var sleepStart_TF: UITextField!
    @IBOutlet weak var sleepEnd_TF: UITextField!
    @IBOutlet weak var tiredRevel_TF: UITextField!
    
    let loadDate_Formatter = DateFormatter()  //DP
    var dateDeta: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    
    var placeType_PV = UIPickerView()
    var practicePoint_PV = UIPickerView()
    var mealTime_PV = UIPickerView()
    var sleepStart_PV = UIPickerView()
    var sleepEnd_PV = UIPickerView()
    var tiredRevel_PV = UIPickerView()
    
    
    var placeType_Array = ["トラック","ロード","校庭","公園","ランニングコース","その他"]
    var practicePoint_Array = ["★☆☆☆☆","★★☆☆☆","★★★☆☆","★★★★☆","★★★★★"]
    var mealTime_Array = ["1回","2回","3回","4回","5回"]
    var sleepStart_Array = ["18:00","19:00","20:00","21:00","22:00"]
    var sleepEnd_Array = ["18:00","19:00","20:00","21:00","22:00"]
    var tiredRevel_Array = ["余力あり 5","余力ややあり 4","やや疲れた 3","疲れた 2","かなり疲れた 1"]
    var error_Array = ["エラー"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date
        let today = Date()
        loadDate_Formatter.dateFormat = "yyyy/MM/dd/E"//2022/07/12/日 履歴のための現在日時の取得
        dateDeta = loadDate_Formatter.string(from: today)
        loadDate_Formatter.dateFormat = "M"
        todayMonth = loadDate_Formatter.string(from: today)
        loadDate_Formatter.dateFormat = "d"
        todayDay = loadDate_Formatter.string(from: today)
        loadDate_Formatter.dateFormat = "E"
        todayYobi = loadDate_Formatter.string(from: today)
        
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
        
        print("日時デフォルト値: \(dateDeta)")
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
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PV
        let pvArray = [placeType_PV,practicePoint_PV,mealTime_PV,sleepStart_PV,sleepEnd_PV,tiredRevel_PV]
        let tfArray = [placeType_TF,practicePoint_TF,mealTime_TF,sleepStart_TF,sleepEnd_TF,tiredRevel_TF]
        
        for n in 0...pvArray.count - 1 {
            
            let pv = pvArray[n]
            let tf = tfArray[n]
            
            pv.delegate = self
            pv.dataSource = self
            tf?.inputView = pv
            tf?.inputAccessoryView = toolbar
            pv.tag = n + 1
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //PV
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return placeType_Array.count
        } else if pickerView.tag == 2 {
            return practicePoint_Array.count
        } else if pickerView.tag == 3 {
            return mealTime_Array.count
        } else if pickerView.tag == 4 {
            return sleepStart_Array.count
        } else if pickerView.tag == 5 {
            return sleepEnd_Array.count
        } else if pickerView.tag == 6 {
            return tiredRevel_Array.count
        } else {
            return error_Array.count
        }
    }
     
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return placeType_Array[row]
        } else if pickerView.tag == 2 {
            return practicePoint_Array[row]
        } else if pickerView.tag == 3 {
            return mealTime_Array[row]
        } else if pickerView.tag == 4 {
            return sleepStart_Array[row]
        } else if pickerView.tag == 5 {
            return sleepEnd_Array[row]
        } else if pickerView.tag == 6 {
            return tiredRevel_Array[row]
        } else {
            return error_Array[row]
        }
    }
     
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 処理
        
        if pickerView.tag == 1 {
            placeType_TF.text = placeType_Array[row]
        } else if pickerView.tag == 2 {
            practicePoint_TF.text = practicePoint_Array[row]
        } else if pickerView.tag == 3 {
            mealTime_TF.text = mealTime_Array[row]
        } else if pickerView.tag == 4 {
            sleepStart_TF.text = sleepStart_Array[row]
        } else if pickerView.tag == 5 {
            sleepEnd_TF.text = sleepEnd_Array[row]
        } else if pickerView.tag == 6 {
            tiredRevel_TF.text = tiredRevel_Array[row]
        }
    }
    
    
    
        
    @objc func done() {
        self.view.endEditing(true)
    }
    
    
    
    
    @IBAction func practice_record() {
        
        self.performSegue(withIdentifier: "go-record-1", sender: self)
        
    }
    
//    @IBAction func place_field_record() {
//
//    }
    
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
