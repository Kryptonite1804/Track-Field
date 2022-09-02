//
//  Record-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


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
    @IBOutlet weak var tiredLevelButton: UIButton!
    
    @IBOutlet weak var placeType_TF: UITextField!
    @IBOutlet weak var practicePoint_TF: UITextField!
    @IBOutlet weak var mealTime_TF: UITextField!
    @IBOutlet weak var sleepStart_TF: UITextField!
    @IBOutlet weak var sleepEnd_TF: UITextField!
    @IBOutlet weak var tiredLevel_TF: UITextField!
    
    
    @IBOutlet weak var painTF_Label: UILabel!
    
    
    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!  //scrollview_キーボード_ずらす
    
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    
    let loadDate_Formatter = DateFormatter()  //DP
    var dateDeta: String = ""
    var todayYear: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    
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
    
    
    var painTF_String: String = ""
    var painLebel_String: String = ""
    var painWriting_String: String = ""
    
    
    var username: String = ""
    
    
    
    var painPlace_Dictionary: [String:String] = ["pain_button1": "なし","pain_button2": "なし","pain_button3": "なし","pain_button4": "なし","pain_button5": "なし","pain_button6": "なし","pain_button7": "なし","pain_button8": "なし","pain_button9": "なし","pain_button10": "なし","pain_button11": "なし","pain_button12": "なし","pain_button13": "なし","pain_button14": "なし","pain_button15": "なし","pain_button216": "なし","pain_button17": "なし","pain_button18": "なし","pain_button19": "なし","pain_button20": "なし","pain_button21": "なし","pain_button22": "なし","pain_button23": "なし","pain_button24": "なし"]
    
    
    
    var empty_Dictionary: Dictionary = ["main":"","sub":"","free":""]
    
    var team_String: String = ""
    
    var team_Dictionary: Dictionary = ["main":"","sub":"","free":""]
    var practiceType_Dictionary: Dictionary = ["main":"","sub":"","free":""]
    var practiceContent_Dictionary: Dictionary = ["main":"","sub":"","free":""]
    
    var upDistance_Dictionary :Dictionary = ["main":"","sub":"","free":""]
    var downDistance_Dictionary :Dictionary = ["main":"","sub":"","free":""]
    
    var totalDistance_String :String = ""
    
    var upTime_Dictionary :Dictionary = ["main":"","sub":"","free":""]
    var downTime_Dictionary :Dictionary = ["main":"","sub":"","free":""]
    
    var runDetail_Dictionary :[String:Any]!
    
    var writing_YN :String = "NO"
    
    
    let dateFormatter = DateFormatter()
    
    
    var placeType_PV = UIPickerView()
    var practicePoint_PV = UIPickerView()
    var mealTime_PV = UIPickerView()
    var sleepStart_PV = UIPickerView()
    var sleepEnd_PV = UIPickerView()
    var tiredLevel_PV = UIPickerView()
    
    
    var placeType_Array = ["トラック","ロード","校庭","公園","ランニングコース","その他"]
    var practicePoint_Array = ["★☆☆☆☆","★★☆☆☆","★★★☆☆","★★★★☆","★★★★★"]
    var mealTime_Array = ["1回","2回","3回","4回","5回"]
//    var sleepStart_Array = ["18:00","19:00","20:00","21:00","22:00"]
//    var sleepEnd_Array = ["18:00","19:00","20:00","21:00","22:00"]
    var tiredLevel_Array = ["余力あり 5","余力ややあり 4","やや疲れた 3","疲れた 2","かなり疲れた 1"]
    var error_Array = ["エラー"]
    
    var hourNumber_Array: [String]! = ["12","13","14","15","16","17","18","19","20","21","22","23","00","01","02","03","04","05","06","07","08","09","10","11"]
    var minuteNumber_Array: [String]! = ["00","15","30","45"]
    var timeUnit_Array: [String]! = [":"]
    
    
    
    var userUid: String = ""
    var groupUid: String = ""
//    var dishesDataSecond_Array: [[String: Any]] = []
    var runningData_Dictionary: [String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date
        let today = Date()
        
        
        loadDate_Formatter.locale = Locale(identifier: "ja_JP")
        
        loadDate_Formatter.dateFormat = "yyyy/MM/dd/E"//2022/07/12/日 履歴のための現在日時の取得
        dateDeta = loadDate_Formatter.string(from: today)
        
        loadDate_Formatter.dateFormat = "yyyy"
        todayYear = loadDate_Formatter.string(from: today)
        
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
        
        
        UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)", forKey: "checkDay11")
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        

        
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
            recordMainNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            recordMainNum?.layer.borderWidth = 1.0 // 枠線の太さ
            
        }
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PV
        let pvArray = [placeType_PV,practicePoint_PV,mealTime_PV,sleepStart_PV,sleepEnd_PV,tiredLevel_PV]
        let tfArray = [placeType_TF,practicePoint_TF,mealTime_TF,sleepStart_TF,sleepEnd_TF,tiredLevel_TF]
        
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
        
        //TV
        let costombar = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 40))
        costombar.backgroundColor = UIColor.secondarySystemBackground
        let commitBtn = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width)-50, y: 0, width: 55, height: 40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.link, for: .normal)
        commitBtn.addTarget(self, action: #selector(Record_0_ViewController.onClickCommitButton), for: .touchUpInside)
        costombar.addSubview(commitBtn)
        writing.inputAccessoryView = costombar
        writing.keyboardType = .default
        writing.returnKeyType = .default
        writing.delegate = self
        
        
        //sleepStartTime_Picker初期値
        sleepStart_PV.selectRow(12, inComponent: 0, animated: false)
        sleepStart_PV.selectRow(0, inComponent: 1, animated: false)
        sleepStart_PV.selectRow(0, inComponent: 2, animated: false)
        
        //sleepEndTime_Picker初期値
        sleepEnd_PV.selectRow(12, inComponent: 0, animated: false)
        sleepEnd_PV.selectRow(0, inComponent: 1, animated: false)
        sleepEnd_PV.selectRow(0, inComponent: 2, animated: false)
        
        
        //scrollview_キーボード_ずらす
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillChangeFrame),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        //scrollview_キーボード_ずらす
        
        
        
        //        すでに入力された内容を表示
                let checkDay11 = UserDefaults.standard.string(forKey: "checkDay11")
                let checkDay22 = UserDefaults.standard.string(forKey: "checkDay22")
                if checkDay11 == checkDay22 {
                    
        //            入力された内容を表示
                    self.placeType_String = UserDefaults.standard.string(forKey: "placeType") ?? ""
                    placeType_TF.text = self.placeType_String
                    
                    print("データですよ")
                    print(self.placeType_String)
                    
                    self.practicePoint_String = UserDefaults.standard.string(forKey: "practicePoint") ?? ""
                    practicePoint_TF.text = self.practicePoint_String
                    
                    self.mealTime_String = UserDefaults.standard.string(forKey: "mealTime") ?? ""
                    mealTime_TF.text = self.mealTime_String
                    
                    self.sleepStart_String = UserDefaults.standard.string(forKey: "sleepStart") ?? ""
                    sleepStart_TF.text = self.sleepStart_String
                    
                    self.sleepEnd_String = UserDefaults.standard.string(forKey: "sleepEnd") ?? ""
                    sleepEnd_TF.text = self.sleepEnd_String
                    
                    self.tiredLevel_String = UserDefaults.standard.string(forKey: "tiredLevel") ?? ""
                    tiredLevel_TF.text = self.tiredLevel_String
                    
                    self.writing_String = UserDefaults.standard.string(forKey: "writing") ?? ""
                    writing.text = self.writing_String
                    
                    self.writing_check.image = UIImage(systemName: "checkmark.circle.fill")
                    self.writing_check.tintColor = .link
                    //ブルー - " ✔︎ "
                    self.writing_YN = "YES"
                    
                    self.performSegue(withIdentifier: "already", sender: self)
                    
                    
                } else {
                    
                    print("ここが実行されています")
        //            デフォルト値を表示
                    self.placeType_String = UserDefaults.standard.string(forKey: "placeTypeDefault") ?? ""
                    placeType_TF.text = self.placeType_String
                    
                    self.practicePoint_String = UserDefaults.standard.string(forKey: "practicePointDefault") ?? ""
                    practicePoint_TF.text = self.practicePoint_String
                    
                    self.mealTime_String = UserDefaults.standard.string(forKey: "mealTimeDefault") ?? ""
                    mealTime_TF.text = self.mealTime_String
                    
                    self.sleepStart_String = UserDefaults.standard.string(forKey: "sleepStartDefault") ?? ""
                    sleepStart_TF.text = self.sleepStart_String
                    
                    self.sleepEnd_String = UserDefaults.standard.string(forKey: "sleepEndDefault") ?? ""
                    sleepEnd_TF.text = self.sleepEnd_String
                    
                    self.tiredLevel_String = UserDefaults.standard.string(forKey: "tiredLevelDefault") ?? ""
                    tiredLevel_TF.text = self.tiredLevel_String
                    
                    //痛み_UserDefault_初期値に
                    UserDefaults.standard.set("痛みなし", forKey: "painTF")
            //        UserDefaults.standard.set("", forKey: "painPlace")
                    UserDefaults.standard.set("", forKey: "painLebel")
                    UserDefaults.standard.set("", forKey: "painWriting")
                    
                    //メニューの記録_UserDefault_初期値に
                    UserDefaults.standard.removeObject(forKey: "team")
                    UserDefaults.standard.removeObject(forKey: "practiceType")
                    UserDefaults.standard.removeObject(forKey: "menu")
                    UserDefaults.standard.removeObject(forKey: "upDistance")
                    UserDefaults.standard.removeObject(forKey: "downDistance")
                    UserDefaults.standard.removeObject(forKey: "upTime")
                    UserDefaults.standard.removeObject(forKey: "downTime")
                    
                    UserDefaults.standard.set("", forKey: "totalDistance")
                    
                    print("ここが実行されていました")
                    
                }
        
        
        
                    
                    
                
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        //痛み有無をLabelに反映
        painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
        painTF_Label.text = painTF_String
        
        if painTF_String == "痛みなし" {
            
            painTF_Label.textColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)
            
        } else if painTF_String == "痛みあり" {
            painTF_Label.textColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
        }
        
        
        //メニューの記録有無をImage反映
        team_Dictionary = UserDefaults.standard.dictionary(forKey: "team") as? [String:String] ?? ["main":"","sub":"","free":""]
        let scDictionary = ["main","sub","free"]
        var scString = ""
        var selectedTeam = ""
        
        for n in 0...2 {
            
            scString = scDictionary[n]
            
            selectedTeam = team_Dictionary[scString]!
            
            if team_String != "OK" {
                
            if selectedTeam == "" {
                team_String = ""
            } else {
                team_String = "OK"
            }
                
            }
            
        }
        
        
        
        if team_String == "" {
            //メニューの記録 入力なし
            print("menu is not imported.")
            self.practice_mene_check.image = UIImage(systemName: "exclamationmark.circle.fill")
            self.practice_mene_check.tintColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
            //ピンク - "！"
            
        } else {
            //メニューの記録 入力あり
            print("menu No problem")
            self.practice_mene_check.image = UIImage(systemName: "checkmark.circle.fill")
            self.practice_mene_check.tintColor = .link
            //ブルー - " ✔︎ "
        }
        
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.hidesBackButton = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
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
            placeType_TF.text = placeType_String
            print("placeType: ",placeType_String)
            
        } else if pickerView.tag == 2 {
            
            practicePoint_String = practicePoint_Array[row]
            practicePoint_TF.text = practicePoint_String
            print("practicePoint: ",practicePoint_String)
            
        } else if pickerView.tag == 3 {
            
            mealTime_String = mealTime_Array[row]
            mealTime_TF.text = mealTime_String
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
            sleepStart_TF.text = sleepStart_String
            
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
            sleepEnd_TF.text = sleepEnd_String
            print("sleepEnd: ",sleepEnd_String)
            
        } else if pickerView.tag == 6 {
            
            tiredLevel_String = tiredLevel_Array[row]
            tiredLevel_TF.text = tiredLevel_String
            print("tiredLevel: ",tiredLevel_String)
            
        }
    }
    
        
    @objc func done() {
        self.view.endEditing(true)
    }
    
    
    //TV  //TVの「完了」Buttonが押された際の処理
    @objc func onClickCommitButton(sender: UIButton) {
        if(writing.isFirstResponder) {
            writing.resignFirstResponder()
            writing_String = writing.text
            print("Pushed_impression:\(writing_String)")
            
            let count = self.writing.text.count
            print("writing.text.count: \(count)")
            
            if count < 25 {
                print("impression is too short!\n")
            } else {
                
                print("impression No problem\n")
            }
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.writing_String = self.writing.text!
            print("Load_impression: \(self.writing_String)")
            
            let count = self.writing.text.count
            print("writing.text.count: \(count)")
            
            if count < 25 {
                
                print("impression is too short!")
                self.writing_check.image = UIImage(systemName: "exclamationmark.circle.fill")
                self.writing_check.tintColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
                //ピンク - "！"
//                UIImage(named: "frog9")
                self.writing_YN = "NO"
                
            } else {
                
                print("impression No problem")
                self.writing_check.image = UIImage(systemName: "checkmark.circle.fill")
                self.writing_check.tintColor = .link
                //ブルー - " ✔︎ "
                
                self.writing_YN = "YES"
                
            }
            
        }
        return true
    }
    
    
    
    //scrollview_キーボード_ずらす_ここから
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        print("キーボード表示")
        
        //キーボードのサイズ
  guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
        //キーボードのアニメーション時間
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
        //キーボードのアニメーション曲線
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
        //Outletで結び付けたScrollViewのBottom制約
        let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }

  //キーボードの高さ
  let keyboardHeight = keyboardFrame.height
  //Bottom制約再設定
  scrollViewBottomConstraint.constant = keyboardHeight - 93

  //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
  UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
    self.view.layoutIfNeeded()
  })
      }
    
    
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        print("キーボード非表示")
        
        //キーボードのアニメーション時間
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
                  //キーボードのアニメーション曲線
                  let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
                  //Outletで結び付けたScrollViewのBottom制約
                  let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }

            //画面いっぱいになるのでBottomのマージンを0に戻す
            scrollViewBottomConstraint.constant = 0

            //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
              self.view.layoutIfNeeded()
            })
          
        
      }
    
    //scrollview_キーボード_ずらす_ここまで
    
    
    
    
    
    @IBAction func practice_record() {
        UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)" ,forKey: "checkDay1")
        self.performSegue(withIdentifier: "go-record-1", sender: self)
        
    }
    
//    @IBAction func place_field_record() {
//
//    }
    
    @IBAction func point_record() {
        //必要なし
    }
    
    @IBAction func pain_record() {
        self.performSegue(withIdentifier: "go-record-2", sender: self)
    }
    
    @IBAction func eat_time_record() {
        //必要なし
    }
    
    @IBAction func sleep_start_record() {
        //必要なし
    }
    
    @IBAction func sleep_end_record() {
        //必要なし
    }
    
    @IBAction func tired_record() {
        //必要なし
    }
    
    @IBAction func register() {
        
        
        
        
        if team_String != "" && placeType_String != "" && practicePoint_String != "" && mealTime_String != "" && sleepStart_String != "" && sleepEnd_String != "" && tiredLevel_String != "" && writing_String != "" && writing_YN != "NO" {
        
        
        //登録処理
        
        self.activityIndicatorView.startAnimating()
        
        //Auth - UID取得
        Auth.auth().addStateDidChangeListener { (auth, user) in

            guard let user = user else {

                return
                
            }
            
            self.userUid = user.uid
         
            
            
            //docRef2 - groupUID取得
            let docRef2 = self.db.collection("Users").document("\(self.userUid)")

            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data2: \(documentdata2)")

                    self.groupUid = document.data()!["groupUid"] as! String
            
                    
                    
                    //docRef3 - runningData取得
                    let docRef3 = self.db.collection("Users").document("\(self.userUid)")

                    docRef3.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")
                            
                            let collectionName = "\(self.todayYear)-\(self.todayMonth)"

                            self.runningData_Dictionary = document.data()![collectionName] as? [String:Any] ?? [:]
                            
                            self.username = document.data()!["username"] as? String ?? ""

                            print("runningData_Dictionary: \(self.runningData_Dictionary)")
                            
                            
                            //ここで過去分確認・未入力日の分を入力
                            
                            let recordedDayCount = self.runningData_Dictionary.count
                            
                            let intDay: Int = Int(self.todayDay)!
                            
                            if recordedDayCount < intDay - 1 {
                                
                                for n in recordedDayCount + 1 ... intDay - 1 {
                                    
                                    
                                    //曜日の生成・適正代入
                                    
                                    self.dateFormatter.dateFormat = "yyyy/M/d"
                                    
                                    let applicableDate_DateType = self.dateFormatter.date(from: "\(self.todayYear)/\(self.todayMonth)/\(n)")!
                                print(applicableDate_DateType)
                                
                                let today = Date()
                                    let today_String = self.dateFormatter.string(from: today)
                                    let today_DateType = self.dateFormatter.date(from: today_String)!
                                
                                let elapsedDays = Calendar.current.dateComponents([.day], from: applicableDate_DateType, to: today_DateType).day!
                                    
                                    print("ここですよ",elapsedDays)
                                    
                                    let yobi_Array = ["日","月","火","水","木","金","土"]
                                    var standardNumber: Int = 0
                                    
                                    
                                    for k in 0...6 {
                                        if self.todayYobi == yobi_Array[k] {
                                            standardNumber = k
                                        }
                                    }
                                    
                                    var calculatedNumber = elapsedDays % 7
                                    
                                    calculatedNumber = standardNumber - calculatedNumber
                                    
                                    if calculatedNumber < 0 {
                                        calculatedNumber = calculatedNumber + 7
                                    }
                                    
                                    let yobi = yobi_Array[calculatedNumber]
                                    
                                    //曜日の生成・適正代入
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    let dictionary: [String:Any] = ["yobi": yobi]
                                    self.runningData_Dictionary.updateValue(dictionary, forKey: "\(n)")
                                    
                                }
                                
                            }
                            

//                            UserDefaults.standard.set(self.placeType_String, forKey: "placeType")
//                            UserDefaults.standard.set(self.practicePoint_String, forKey: "practicePoint")
//                            UserDefaults.standard.set(self.mealTime_String, forKey: "mealTime")
//                            UserDefaults.standard.set(self.sleepStart_String, forKey: "sleepStart")
//                            UserDefaults.standard.set(self.sleepEnd_String, forKey: "sleepEnd")
//                            UserDefaults.standard.set(self.tiredLevel_String, forKey: "tiredLevel")
//                            UserDefaults.standard.set(self.writing_String, forKey: "writing")
                            
                            
                            //ここから入力された新規データの追加処理
                            
                            //痛み関連
                            self.painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
                            self.painPlace_Dictionary = UserDefaults.standard.dictionary(forKey: "painPlace") as? [String:String] ?? ["pain_button1": "なし","pain_button2": "なし","pain_button3": "なし","pain_button4": "なし","pain_button5": "なし","pain_button6": "なし","pain_button7": "なし","pain_button8": "なし","pain_button9": "なし","pain_button10": "なし","pain_button11": "なし","pain_button12": "なし","pain_button13": "なし","pain_button14": "なし","pain_button15": "なし","pain_button216": "なし","pain_button17": "なし","pain_button18": "なし","pain_button19": "なし","pain_button20": "なし","pain_button21": "なし","pain_button22": "なし","pain_button23": "なし","pain_button24": "なし"]
                            
                            self.painLebel_String = UserDefaults.standard.string(forKey: "painLebel") ?? ""
                            self.painWriting_String = UserDefaults.standard.string(forKey: "painWriting") ?? ""
                            
                            let painDictonary = ["painTF": self.painTF_String, "painPlace": self.painPlace_Dictionary, "painLebel": self.painLebel_String, "painWriting": self.painWriting_String] as [String : Any]
                            
                            
                            
                            //Record-1で入力した内容
                            self.team_Dictionary = UserDefaults.standard.dictionary(forKey: "team") as? [String:String] ?? self.empty_Dictionary
                            self.practiceType_Dictionary = UserDefaults.standard.dictionary(forKey: "practiceType") as? [String:String] ?? self.empty_Dictionary
                            self.practiceContent_Dictionary = UserDefaults.standard.dictionary(forKey: "menu") as? [String:String] ?? self.empty_Dictionary
                            self.upDistance_Dictionary = UserDefaults.standard.dictionary(forKey: "upDistance") as? [String:String] ?? self.empty_Dictionary
                            self.downDistance_Dictionary = UserDefaults.standard.dictionary(forKey: "downDistance") as? [String:String] ?? self.empty_Dictionary
                            
                            self.totalDistance_String = UserDefaults.standard.string(forKey: "totalDistance") ?? ""
                            
                            self.upTime_Dictionary = UserDefaults.standard.dictionary(forKey: "upTime") as? [String:String] ?? self.empty_Dictionary
                            self.downTime_Dictionary = UserDefaults.standard.dictionary(forKey: "downTime") as? [String:String] ?? self.empty_Dictionary
                            
                            
                            
                            self.runDetail_Dictionary = UserDefaults.standard.dictionary(forKey: "runDetail") ?? self.empty_Dictionary
                            
                            UserDefaults.standard.set(self.placeType_String, forKey: "placeType")
                            UserDefaults.standard.set(self.practicePoint_String, forKey: "practicePoint")
                            UserDefaults.standard.set(self.mealTime_String, forKey: "mealTime")
                            UserDefaults.standard.set(self.sleepStart_String, forKey: "sleepStart")
                            UserDefaults.standard.set(self.sleepEnd_String, forKey: "sleepEnd")
                            UserDefaults.standard.set(self.tiredLevel_String, forKey: "tiredLevel")
                            UserDefaults.standard.set(self.writing_String, forKey: "writing")
                            
                            let menuDictionary = ["team": self.team_Dictionary, "practiceType": self.practiceType_Dictionary, "menu": self.practiceContent_Dictionary, "upDistance": self.upDistance_Dictionary, "downDistance": self.downDistance_Dictionary, "totalDistance": self.totalDistance_String, "upTime": self.upTime_Dictionary, "downTime": self.downTime_Dictionary, "runDetail": self.runDetail_Dictionary] as [String : Any]
                            
                            
                            
                            var dictionary: [String: Any] = [
                                "yobi": self.todayYobi,
                                "placeType": self.placeType_String,
                                "practicePoint": self.practicePoint_String,
                                "mealTime": self.mealTime_String,
                                "sleepStart": self.sleepStart_String,
                                "sleepEnd": self.sleepEnd_String,
                                "tiredLevel": self.tiredLevel_String,
                                "writing": self.writing_String,
                                "pain": painDictonary,
                                "menuBody": menuDictionary
                            ]
                            
                            self.runningData_Dictionary.updateValue(dictionary, forKey: self.todayDay)
                            
                                    
                            
                            
                            let ref = self.db.collection("Users")
                            
                                    ref.document(self.userUid).updateData(
                                        [collectionName : self.runningData_Dictionary])
                                    
                            { err in
                                if let err = err {
                                    //失敗

                                } else {
                                    //成功
                                    print("succeed")
                                    
                                    
                                    
                                        
                                    //docRef3 - runningData取得
                                    let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

                                    docRef3.getDocument { (document, error) in
                                        if let document = document, document.exists {
                                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                                            print("Document data3: \(documentdata3)")
                                            

                                            var groupRunningData_Dictionary = document.data()!["todayData"] as? [String:Any] ?? [:]
                                            
                                            var groupRunningData2_Dictionary = groupRunningData_Dictionary["\(self.todayYear)-\(self.todayMonth)-\(self.todayDay)"] as? [String:Any] ?? [:]
                                            
                                            
//                                            self.runningData_Dictionary.updateValue(dictionary, forKey: self.todayDay)
                                            
                                            dictionary.updateValue(self.username, forKey: "username")
                                            
                                            groupRunningData2_Dictionary.updateValue(dictionary, forKey: "username")
                                            groupRunningData_Dictionary.updateValue(groupRunningData2_Dictionary, forKey: "\(self.todayYear)-\(self.todayMonth)-\(self.todayDay)")
                                            
                                            
                                            let ref = self.db.collection("Group")
                                            
                                                    ref.document(self.groupUid).updateData(
                                                        ["todayData" : groupRunningData_Dictionary])
                                                    
                                            { err in
                                                if let err = err {
                                                    //失敗

                                                } else {
                                                    //成功
                                                    print("succeed")
                                                    
                                                    
                                                    self.activityIndicatorView.stopAnimating()
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    //ここから
                                                    
                                                        //MyAlert
                                                        //poptoroot
                                                        
                                                    let alert: UIAlertController = UIAlertController(title: "登録完了！",message: "お疲れ様でした！\n今日の練習記録を登録しました！", preferredStyle: UIAlertController.Style.alert)
                                                    let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                                                        (action: UIAlertAction!) -> Void in
                                                        
                                                        self.performSegue(withIdentifier: "already", sender: self)
                                                        
                                                    })
                                                    
                                                    alert.addAction(confilmAction)
                                                    
                                                    UserDefaults.standard.set("\(self.todayYear)/\(self.todayMonth)/\(self.todayDay)", forKey: "checkDay22")
                                                    
                                                    //alertを表示
                                                    self.present(alert, animated: true, completion: nil)
                                                        
                                                    
                                                    
                                                    //ここまで
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        
                                    
                                            //docRef3
                                            } else {
                                                print("Document3 does not exist")

                                                self.activityIndicatorView.stopAnimating()  //AIV
                                                print("ランニング記録なし")
                                                
                                            }  //docRef3
                                        
                                }  //docRef3
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }

                                    
                                    
                            
                            
                            
                        //docRef3
                        } else {
                            print("Document3 does not exist")

                            self.activityIndicatorView.stopAnimating()  //AIV
                            print("ランニング記録なし")
                            
                        }  //docRef3
                    
            }  //docRef3
            
            
        //docRef2
        } else {
            print("Document2 does not exist")

            self.activityIndicatorView.stopAnimating()  //AIV
            self.alert(title: "エラー", message: "ランニング記録の保存に\n失敗しました")
        }  //docRef2
    }  //docRef3
            
            
            
        
        }  //Auth
        
        
        
        
        
    //↓} :全項目入力有無_if文_1つ目閉じ
        } else {
            
            //MARK: if文で一つずつ確認していく
            var errorType_String = ""
            var writingError_Detail = ""
            
        if team_String == "" {
            errorType_String = "メニューの記録が\n"
            
        } else if placeType_String == "" {
            errorType_String = "練習場所タイプが\n"
            
        } else if practicePoint_String == "" {
            errorType_String = "練習評価が"
            
        } else if mealTime_String == "" {
            errorType_String = "食事の回数が"
            
        } else if sleepStart_String == "" {
            errorType_String = "睡眠開始時間が\n"
            
        } else if sleepEnd_String == "" {
            errorType_String = "睡眠終了時間が\n"
            
        } else if tiredLevel_String == "" {
            errorType_String = "疲労度が"
            
        } else if writing_String == "" {
            errorType_String = "感想が"
            
        } else if writing_YN == "NO" {
            errorType_String = "感想が\n十分に"
            writingError_Detail = "\n感想は25文字以上入力してください。"
        }
            
            alert(title: "\(errorType_String)入力されていません", message: "すべての項目を記入後、\n「登録する」ボタンを押してください。\(writingError_Detail)")
            
    }  //↓} :全項目入力有無_if文_2つ目閉じ
        
    }  //IBaction
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
