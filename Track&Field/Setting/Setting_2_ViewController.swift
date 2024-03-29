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
    
//    var placeType_String: String = ""
//    var practicePoint_String: String = ""
//    var mealTime_String: String = ""
//    var tiredLevel_String: String = ""
//    var writing_String: String = ""
//
//
//    var sleepStart_String: String = ""
//    var sleepEnd_String: String = ""
    
    var sleepStartHour_String :String = "0"
    var sleepStartMinute_String :String = "00"
    
    var sleepEndHour_String :String = "0"
    var sleepEndMinute_String :String = "00"
    
    var baseData: BaseData?
    
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
        
        baseData = UserDefaults.standard.object(forKey: "defaultData") as? BaseData ?? BaseData()
        setUI()
    }
    
    
    func setUI() {
        
        placeType_textfield.text = baseData?.placeType ?? ""
        practicePoint_textfield.text = baseData?.practicePoint ?? ""
        eatTime_textfield.text = baseData?.mealTime ?? ""
        sleepStart_textfield.text = baseData?.sleepStart ?? ""
        sleepEnd_textfield.text = baseData?.sleepEnd ?? ""
        tiredLevel_textfield.text = baseData?.tiredLevel ?? ""
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
        if (pickerView.tag == 1 || pickerView.tag == 2 || pickerView.tag == 3 || pickerView.tag == 6) && row == 0 {
            // "- - -"の際は何もしない
        } else {
            
            if pickerView.tag == 1 {
                baseData?.placeType = placeType_Array[row]
                print("placeType: ",(baseData?.placeType)!)
                
            } else if pickerView.tag == 2 {
                baseData?.practicePoint = practicePoint_Array[row]
                print("practicePoint: ",(baseData?.practicePoint)!)
                
            } else if pickerView.tag == 3 {
                baseData?.mealTime = mealTime_Array[row]
                print("mealTime: ",(baseData?.mealTime)!)
                
            } else if pickerView.tag == 4 {
                
                switch component {
                case 0:
                    sleepStartHour_String = hourNumber_Array[row]
                case 2:
                    sleepStartMinute_String = minuteNumber_Array[row]
                default:
                    break
                }
                
                baseData?.sleepStart = "\(sleepStartHour_String):\(sleepStartMinute_String)"
                print("sleepStart: ",(baseData?.sleepStart)!)
                
            } else if pickerView.tag == 5 {
                
                switch component {
                case 0:
                    sleepEndHour_String = hourNumber_Array[row]
                case 2:
                    sleepEndMinute_String = minuteNumber_Array[row]
                default:
                    break
                }
                
                baseData?.sleepEnd = "\(sleepEndHour_String):\(sleepEndMinute_String)"
                print("sleepEnd: ",(baseData?.sleepEnd)!)
                
            } else if pickerView.tag == 6 {
                
                baseData?.tiredLevel = tiredLevel_Array[row]
                print("tiredLevel: ",(baseData?.tiredLevel)!)
                
            }
        }
        setUI()
    }
    
    
    @IBAction func tap3(_ sender: UITextField) {
//        eatTime_PIcture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel3(_ sender: UITextField) {
//        eatTime_PIcture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func eattime_button(_ sender: UITextField) {
//        eatTime_PIcture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func cancel5(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func tap5(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func sleepend_button(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func tap4(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel4(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func sleepstart_button(_ sender: UITextField) {
//        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func cancel6(_ sender: UITextField) {
//        tiredLevel_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func tap6(_ sender: UITextField) {
//        tiredLevel_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func tired_button(_ sender: UITextField) {
//        tiredLevel_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    
    
    @IBAction func tap2(_ sender: UITextField) {
//        practicePoint_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel2(_ sender: UITextField) {
//        practicePoint_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func practicepoint_button(_ sender: UITextField) {
//        practicePoint_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    @IBAction func tap1(_ sender: UITextField) {
//        practiceType_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel1(_ sender: UITextField) {
//        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func practiceplace_button(_ sender: UITextField) {
//        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func register() {
        regist_picture.image = UIImage(named: "p_nonpushed_s")
        
        let stringCheckArray = [baseData?.placeType,baseData?.practicePoint,baseData?.mealTime,baseData?.sleepStart,baseData?.sleepEnd,baseData?.tiredLevel]
        var stringCheckBool = true
        for (stringCheckString) in stringCheckArray {
            if stringCheckBool && stringCheckString == nil {
                stringCheckBool = false
            }
        }
        
        
        if stringCheckBool {
            
            UserDefaults.standard.set(baseData, forKey: "defaultData")
            
            AlertHost.alertDef(view: self, title: "デフォルト値を保存しました", message: "今後は記録する際に保存したデフォルト値がはじめに表示されます。") { _ in
                
                let defaultFrom = UserDefaults.standard.string(forKey: "DefaultFrom")
                if defaultFrom == "Register" {
                    UserDefaults.standard.set("Done", forKey: "DefaultFrom")
                    self.performSegue(withIdentifier: "go-1-5-1", sender: self)
                    
                } else {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            }
            
        } else {
            AlertHost.alertDef(view: self, title: "デフォルト値が保存できませんでした", message: "いずれか未入力の項目があります")
        }
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
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
