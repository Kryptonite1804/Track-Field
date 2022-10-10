//
//  Setting_2_ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/08/11.
//

import UIKit
import SafariServices

class Setting_2_ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var practicePoint_picture: UIImageView!
    @IBOutlet weak var eatTime_PIcture: UIImageView!
    @IBOutlet weak var sleep_picture: UIImageView!
    @IBOutlet weak var tiredLevel_picture: UIImageView!
    
    @IBOutlet weak var placeType_textfield: UITextField!
    @IBOutlet weak var practicePoint_textfield: UITextField!
    @IBOutlet weak var eatTime_textfield: UITextField!
    @IBOutlet weak var sleepStart_textfield: UITextField!
    @IBOutlet weak var sleepEnd_textfield: UITextField!
    @IBOutlet weak var tiredLevel_textfield: UITextField!
    
    @IBOutlet weak var regist_picture: UIImageView!
    
    var placeType_PV = UIPickerView()
    var practicePoint_PV = UIPickerView()
    var mealTime_PV = UIPickerView()
    var sleepStart_PV = UIPickerView()
    var sleepEnd_PV = UIPickerView()
    var tiredLevel_PV = UIPickerView()
    
    var notSelected_String = "- - -"
        
    var placeType_Array = ["- - -","トラック","ロード","校庭","公園","ランニングコース","その他"]
    var practicePoint_Array = ["- - -","★☆☆☆☆","★★☆☆☆","★★★☆☆","★★★★☆","★★★★★"]
    var mealTime_Array = ["- - -","1回","2回","3回","4回","5回"]
    var tiredLevel_Array = ["- - -","余力あり 5","余力ややあり 4","やや疲れた 3","疲れた 2","かなり疲れた 1"]
    var error_Array = ["エラー"]
    var hourNumber_Array: [String]! = ["12","13","14","15","16","17","18","19","20","21","22","23","00","01","02","03","04","05","06","07","08","09","10","11"]
    var minuteNumber_Array: [String]! = ["00","15","30","45"]
    var timeUnit_Array: [String]! = [":"]
    
    var placeType_String: String = ""
    var practicePoint_String: String = ""
    var mealTime_String: String = ""
    var tiredLevel_String: String = ""
    var writing_String: String = ""
    
    
    var sleepStart_String: String = ""
    var sleepEnd_String: String = ""
    
    var sleepStartHour_String :String = "0"
    var sleepStartMinute_String :String = "00"
    
    var sleepEndHour_String :String = "0"
    var sleepEndMinute_String :String = "00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PV
        let pvArray = [placeType_PV,practicePoint_PV,mealTime_PV,sleepStart_PV,sleepEnd_PV,tiredLevel_PV]
        let tfArray = [placeType_textfield,practicePoint_textfield,eatTime_textfield,sleepStart_textfield,sleepEnd_textfield,tiredLevel_textfield]
        
        for n in 0...pvArray.count - 1 {
            
            let pv = pvArray[n]
            let tf = tfArray[n]
            
            pv.delegate = self
            pv.dataSource = self
            tf?.inputView = pv
            tf?.inputAccessoryView = toolbar
            pv.tag = n + 1
            
            tf?.tintColor = UIColor.clear
        }
        
//        装飾
//        let design = [practiceType_picture,practicePoint_picture,eatTime_PIcture,sleep_picture,tiredLevel_picture]
//        for n in 0...design.count-1 {
//            let designNum = design[n]
//            designNum?.layer.cornerRadius = 22
//            designNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
//            designNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
//            designNum?.layer.shadowOpacity = 0.25  //影の濃さ
//            designNum?.layer.shadowRadius = 4.0 // 影のぼかし量
//            designNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
//            designNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
//            designNum?.layer.borderWidth = 1.0 // 枠線の太さ
//        }

        //sleepStartTime_Picker初期値
        sleepStart_PV.selectRow(12, inComponent: 0, animated: false)
        sleepStart_PV.selectRow(0, inComponent: 1, animated: false)
        sleepStart_PV.selectRow(0, inComponent: 2, animated: false)
        
        //sleepEndTime_Picker初期値
        sleepEnd_PV.selectRow(12, inComponent: 0, animated: false)
        sleepEnd_PV.selectRow(0, inComponent: 1, animated: false)
        sleepEnd_PV.selectRow(0, inComponent: 2, animated: false)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.placeType_String = UserDefaults.standard.string(forKey: "placeTypeDefault") ?? ""
        placeType_textfield.text = self.placeType_String
        
        self.practicePoint_String = UserDefaults.standard.string(forKey: "practicePointDefault") ?? ""
        practicePoint_textfield.text = self.practicePoint_String
        
        self.mealTime_String = UserDefaults.standard.string(forKey: "mealTimeDefault") ?? ""
        eatTime_textfield.text = self.mealTime_String
        
        self.sleepStart_String = UserDefaults.standard.string(forKey: "sleepStartDefault") ?? ""
        sleepStart_textfield.text = self.sleepStart_String
        
        self.sleepEnd_String = UserDefaults.standard.string(forKey: "sleepEndDefault") ?? ""
        sleepEnd_textfield.text = self.sleepEnd_String
        
        self.tiredLevel_String = UserDefaults.standard.string(forKey: "tiredLevelDefault") ?? ""
        tiredLevel_textfield.text = self.tiredLevel_String
    }
    
    
    //PV
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 4 {
            
            return 3
            
        } else if pickerView.tag == 5 {
            
            return 3
            
        } else {
            
            return 1
            
        }
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
            
            switch component {
            case 0:
                return hourNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return minuteNumber_Array.count
            default:
                return 0
            }
            
        } else if pickerView.tag == 5 {
            
            switch component {
            case 0:
                return hourNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return minuteNumber_Array.count
            default:
                return 0
            }
            
        } else if pickerView.tag == 6 {
            return tiredLevel_Array.count
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
            
            switch component {
            case 0:
                return hourNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return minuteNumber_Array[row]
            default:
                return "error"
            }
            
        } else if pickerView.tag == 5 {
            
            switch component {
            case 0:
                return hourNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return minuteNumber_Array[row]
            default:
                return "error"
            }
            
        } else if pickerView.tag == 6 {
            return tiredLevel_Array[row]
        } else {
            return error_Array[row]
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 処理
        
        if pickerView.tag == 1 {
            
            placeType_String = placeType_Array[row]
            placeType_textfield.text = placeType_String
            print("placeType: ",placeType_String)
            
        } else if pickerView.tag == 2 {
            
            practicePoint_String = practicePoint_Array[row]
            practicePoint_textfield.text = practicePoint_String
            print("practicePoint: ",practicePoint_String)
            
        } else if pickerView.tag == 3 {
            
            mealTime_String = mealTime_Array[row]
            eatTime_textfield.text = mealTime_String
            print("mealTime: ",mealTime_String)
            
        } else if pickerView.tag == 4 {
            
            switch component {
            case 0:
                sleepStartHour_String = hourNumber_Array[row]
            case 2:
                sleepStartMinute_String = minuteNumber_Array[row]
            default:
                break
            }
            
            sleepStart_String = "\(sleepStartHour_String):\(sleepStartMinute_String)"
            sleepStart_textfield.text = sleepStart_String
            
            print("sleepStart: ",sleepStart_String)
            
        } else if pickerView.tag == 5 {
            
            switch component {
            case 0:
                sleepEndHour_String = hourNumber_Array[row]
            case 2:
                sleepEndMinute_String = minuteNumber_Array[row]
            default:
                break
            }
            
            sleepEnd_String = "\(sleepEndHour_String):\(sleepEndMinute_String)"
            sleepEnd_textfield.text = sleepEnd_String
            print("sleepEnd: ",sleepEnd_String)
            
        } else if pickerView.tag == 6 {
            
            tiredLevel_String = tiredLevel_Array[row]
            tiredLevel_textfield.text = tiredLevel_String
            print("tiredLevel: ",tiredLevel_String)
            
        }
    }
    
    
    @IBAction func tap2(_ sender: UITextField) {
        practicePoint_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel2(_ sender: UITextField) {
        practicePoint_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func practicepoint_button(_ sender: UITextField) {
        practicePoint_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    @IBAction func tap1(_ sender: UITextField) {
        practiceType_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel1(_ sender: UITextField) {
        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func practiceplace_button(_ sender: UITextField) {
        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func register() {
        regist_picture.image = UIImage(named: "p_pushed_s")
        
        var stringCheckArray = [placeType_String,practicePoint_String,mealTime_String,sleepStart_String,sleepEnd_String,tiredLevel_String]
        var stringCheckBool = true
        
        for n in 0...stringCheckArray.count - 1 {
            if stringCheckBool != false {
                
                let stringCheckString = stringCheckArray[n]
                
                if stringCheckString == "" || stringCheckString == "- - -" {
                    stringCheckBool = false
                }
            }
        }
        
        
        if stringCheckBool == true {
            UserDefaults.standard.set(placeType_String, forKey: "placeTypeDefault")
            UserDefaults.standard.set(practicePoint_String, forKey: "practicePointDefault")
            UserDefaults.standard.set(mealTime_String, forKey: "mealTimeDefault")
            UserDefaults.standard.set(sleepStart_String, forKey: "sleepStartDefault")
            UserDefaults.standard.set(sleepEnd_String, forKey: "sleepEndDefault")
            UserDefaults.standard.set(tiredLevel_String, forKey: "tiredLevelDefault")
            let alert: UIAlertController = UIAlertController(title: "デフォルト値を保存しました",message: "今後は記録する際に保存したデフォルト値がはじめに表示されます。", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                
                
                let defaultFrom = UserDefaults.standard.string(forKey: "DefaultFrom")
                
                if defaultFrom == "Register" {
                    
                    UserDefaults.standard.set("Done", forKey: "DefaultFrom")
                    self.performSegue(withIdentifier: "go-1-5-1", sender: self)
                    
                } else {
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                }
                
                
                
                
                
                
                
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "デフォルト値が保存できませんでした",message: "未入力の項目がないか確認してください。", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
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
    
    
    
    @objc func done() {
        self.view.endEditing(true)
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
