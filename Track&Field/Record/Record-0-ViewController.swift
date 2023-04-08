//
//  Record-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//
//要修正

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
//import SafariServices


class Record_0_ViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource/*, SFSafariViewControllerDelegate*/ {
    
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
    
    @IBOutlet weak var regist_picture: UIImageView!
    
    @IBOutlet weak var painTF_Label: UILabel!
    
    
    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!  //scrollview_キーボード_ずらす
    
    
    let db = Firestore.firestore()
    
    let loadDate_Formatter = DateFormatter()  //DP
    var dateDeta: String = ""
    var todayYear: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    var baseData: BaseData?
    
    var sleepStartHour_String :String = "0"
    var sleepStartMinute_String :String = "00"
    
    var sleepEndHour_String :String = "0"
    var sleepEndMinute_String :String = "00"
    
    var pain_Dict: [String: Any] = [:]
    
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
    
    var placeType_Array = ["- - -","トラック","ロード","校庭","公園","ランニングコース","その他"]
    var practicePoint_Array = ["- - -","★☆☆☆☆","★★☆☆☆","★★★☆☆","★★★★☆","★★★★★"]
    var mealTime_Array = ["- - -","1回","2回","3回","4回","5回"]
    var tiredLevel_Array = ["- - -","余力あり 5","余力ややあり 4","やや疲れた 3","疲れた 2","かなり疲れた 1"]
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
        } else {
            month.text = "0\(todayMonth)"
        }
        
        if intDay > 9  {
            day.text = todayDay
        } else  {
            day.text = "0\(todayDay)"
        }
        
        date.text = "(\(todayYobi))"
        
        print("日時デフォルト値: \(dateDeta)")
        print("月:",month.text ?? "(不明)")
        print("日:",day.text ?? "(不明)")
        print("曜日:",date.text ?? "(不明)")
        
        UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)", forKey: "checkDay11")
        
//        //Toolbar
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
//        let keyboard = KeyBoardHost.init(vc: self)
//        let toolbar = keyboard.toolbar()
        let toolbar = KeyBoardHost.toolbar(vc: self)
        
        
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
        
        
        //すでに入力された内容を表示
        let checkDay11 = UserDefaults.standard.string(forKey: "checkDay11")
        let checkDay22 = UserDefaults.standard.string(forKey: "checkDay22")
        
        if checkDay11 == checkDay22 {
            //入力された内容を表示
            baseData = UserDefaults.standard.object(forKey: "baseData") as? BaseData ?? BaseData()
            setUI()
            writingCountCheck()
            
            self.performSegue(withIdentifier: "already", sender: self)
            
        } else {
            
            //デフォルト値を表示
            baseData = UserDefaults.standard.object(forKey: "defaultData") as? BaseData ?? BaseData()
            setUI()
            writingCountCheck()
            UserDefaults.standard.removeObject(forKey: "baseData")
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //痛み有無をLabelに反映
        pain_Dict = baseData?.pain ?? [:]
        painTF_Label.text = pain_Dict["painTF"] as? String ?? "痛みなし"
        painTF_Label.textColor = Asset.mainColor.color
        if pain_Dict["painTF"] as? String ?? "痛みなし" == "痛みあり" {
            painTF_Label.textColor = Asset.subRedColor.color
        }
        
        //メニューの記録有無をImage反映
        
        let menuCheck = UserDefaults.standard.bool(forKey: "menuCheck")
        
        if menuCheck {
            //メニューの記録 入力あり
            print("menu is already imported.")
            self.practice_mene_check.image = UIImage(systemName: "checkmark.circle.fill")
            self.practice_mene_check.tintColor = .link //ブルー - " ✔︎ "
            
        } else {
           //メニューの記録 入力なし
           print("menu is not imported.")
           self.practice_mene_check.image = UIImage(systemName: "exclamationmark.circle.fill")
           self.practice_mene_check.tintColor = Asset.subRedColor.color //ピンク - "！"
       }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.hidesBackButton = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    func setUI() {
        
        placeType_TF.text = baseData?.placeType
        practicePoint_TF.text = baseData?.practicePoint
        mealTime_TF.text = baseData?.mealTime
        sleepStart_TF.text = baseData?.sleepStart
        sleepEnd_TF.text = baseData?.sleepEnd
        tiredLevel_TF.text = baseData?.tiredLevel
        writing.text = baseData?.writing
        
    }
    
    
    func writingCountCheck() {
        print("impression: \(baseData?.writing ?? "none")")
        let count = baseData?.writing?.count ?? 0
        if count < 25 {
            print("impression is too short!")
            self.writing_check.image = UIImage(systemName: "exclamationmark.circle.fill")
            self.writing_check.tintColor = Asset.subRedColor.color  //ピンク - "！"
            
        } else {
            print("impression is imported.")
            self.writing_check.image = UIImage(systemName: "checkmark.circle.fill")
            self.writing_check.tintColor = .link  //ブルー - " ✔︎ "
        }
    }
    
    
    //PV
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 4 || pickerView.tag == 5 {
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
    
    
//    @objc func done() {
//        self.view.endEditing(true)
//    }
    
    
    //TV  //TVの「完了」Buttonが押された際の処理
    @objc func onClickCommitButton(sender: UIButton) {
        if (writing.isFirstResponder) {
            writing.resignFirstResponder()
            baseData?.writing = writing.text
            print("Pushed_impression:\((baseData?.writing)!)")
            writingCountCheck()
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.baseData?.writing = self.writing.text!
            print("Load_impression: \((self.baseData?.writing)!)")
            self.writingCountCheck()
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
    
    @IBAction func tap1(_ sender: UIButton) {
        practicemene_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel1(_ sender: UIButton) {
        practicemene_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func practice_record() {
        practicemene_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)" ,forKey: "checkDay1")
        self.performSegue(withIdentifier: "go-record-1", sender: self)
        
    }
    
    @IBAction func tap2(_ sender: UIButton) {
        placefeild_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        placefeild_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func place_field_record() {
        placefeild_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func tap3(_ sender: UIButton) {
        point_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel3(_ sender: UIButton) {
        point_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func point_record() {
        point_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        //必要なし
    }
    
    @IBAction func tap4(_ sender: UIButton) {
        pain_pisture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel4(_ sender: UIButton) {
        pain_pisture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func pain_record() {
        pain_pisture.image = UIImage(named: "p_rectangle_detail_M_D")
        self.performSegue(withIdentifier: "go-record-2", sender: self)
    }
    
    @IBAction func tap5(_ sender: UIButton) {
        eatTime_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel5(_ sender: UIButton) {
        eatTime_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func eat_time_record() {
        eatTime_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        //必要なし
    }
    
    @IBAction func tap6(_ sender: UIButton) {
        sleep_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel6(_ sender: UIButton) {
        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func sleep_start_record() {
        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        //必要なし
    }
    
    @IBAction func tap7(_ sender: UIButton) {
        sleep_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel7(_ sender: UIButton) {
        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func sleep_end_record() {
        sleep_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        //必要なし
    }
    
    @IBAction func tap8(_ sender: UIButton) {
        tired_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel8(_ sender: UIButton) {
        tired_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func tired_record() {
        tired_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        //必要なし
    }
    
    @IBAction func tap10(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_pushed_s")
    }
    @IBAction func cancel10(_ sender: UIButton) {
        regist_picture.image = UIImage(named: "p_nonpushed_s")
    }
    @IBAction func register() {
//        regist_picture.image = UIImage(named: "p_nonpushed_s")
//
//        //TODO: ここから！！
//
//        if (team_String != "" || team_String != "- - -") != "" && (placeType_String != "" || placeType_String != "- - -") && (practicePoint_String != "" || practicePoint_String != "- - -") && (mealTime_String != "" || mealTime_String != "- - -") && sleepStart_String != "" && sleepEnd_String != "" && (tiredLevel_String != "" || tiredLevel_String != "- - -") && writing_String != "" && writing_YN != "NO" {
//
//            //TODO: 特にここ！！
//            //登録処理
//            OtherHost.activityIndicatorView(view: view).startAnimating()
//
//            //Auth - UID取得
//            let task = Task {
//                do {
////                    self.userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
////                    self.groupUid = try await FirebaseClient.shared.getUserData().groupUid ?? ""
////                    self.runningData_Dictionary = try await FirebaseClient.shared.getPracticeHistory(year: todayYear, month: todayMonth)
////                    self.username = try await FirebaseClient.shared.getUserData().username ?? ""
////
////                    let collectionName = "\(todayYear)-\(todayDay)"
////                    print("runningData_Dictionary: \(self.runningData_Dictionary)")
////
////                    //ここで過去分確認・未入力日の分を入力
////                    let recordedDayCount = self.runningData_Dictionary.count
////                    let intDay: Int = Int(self.todayDay) ?? 0
////
////                    if recordedDayCount < intDay - 1 {
////
////                        for n in recordedDayCount + 1 ... intDay - 1 {
////                            //曜日の生成・適正代入
////                            self.dateFormatter.dateFormat = "yyyy/M/d"
////                            let applicableDate_DateType = self.dateFormatter.date(from: "\(self.todayYear)/\(self.todayMonth)/\(n)")!
////                            print(applicableDate_DateType)
////
////                            let today = Date()
////                            let today_String = self.dateFormatter.string(from: today)
////                            let today_DateType = self.dateFormatter.date(from: today_String)!
////
////                            let elapsedDays = Calendar.current.dateComponents([.day], from: applicableDate_DateType, to: today_DateType).day!
////                            print("ここですよ",elapsedDays)
////
////                            let yobi_Array = ["日","月","火","水","木","金","土"]
////                            var standardNumber: Int = 0
////                            for k in 0...6 {
////                                if self.todayYobi == yobi_Array[k] {
////                                    standardNumber = k
////                                }
////                            }
////
////                            var calculatedNumber = elapsedDays % 7
////                            calculatedNumber = standardNumber - calculatedNumber
////                            if calculatedNumber < 0 {
////                                calculatedNumber = calculatedNumber + 7
////                            }
////
////                            let yobi = yobi_Array[calculatedNumber]
////
////                            //曜日の生成・適正代入
////                            let dictionary: [String:Any] = ["yobi": yobi]
////                            self.runningData_Dictionary.updateValue(dictionary, forKey: "\(n)")
////
////                        }
////                    }
////
////                    //ここから入力された新規データの追加処理
////
////                    //痛み関連
////                    self.painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
////                    self.painPlace_Dictionary = UserDefaults.standard.dictionary(forKey: "painPlace") as? [String:String] ?? ["pain_button1": "なし","pain_button2": "なし","pain_button3": "なし","pain_button4": "なし","pain_button5": "なし","pain_button6": "なし","pain_button7": "なし","pain_button8": "なし","pain_button9": "なし","pain_button10": "なし","pain_button11": "なし","pain_button12": "なし","pain_button13": "なし","pain_button14": "なし","pain_button15": "なし","pain_button216": "なし","pain_button17": "なし","pain_button18": "なし","pain_button19": "なし","pain_button20": "なし","pain_button21": "なし","pain_button22": "なし","pain_button23": "なし","pain_button24": "なし"]
////
////                    self.painLebel_String = UserDefaults.standard.string(forKey: "painLebel") ?? ""
////                    self.painWriting_String = UserDefaults.standard.string(forKey: "painWriting") ?? ""
////
////                    let painDictonary = ["painTF": self.painTF_String, "painPlace": self.painPlace_Dictionary, "painLebel": self.painLebel_String, "painWriting": self.painWriting_String] as [String : Any]
////
////
////                    //Record-1で入力した内容
////                    let recordedKayDict = ["team","practiceType","menu","upDistance","downDistance","upTime","downTime","runDetail"]
////                    var recordedValueDict = [team_Dictionary,practiceType_Dictionary,practiceContent_Dictionary,upDistance_Dictionary,downDistance_Dictionary,upTime_Dictionary,downTime_Dictionary,runDetail_Dictionary]
////                    for n in 0...recordedKayDict.count-1 {
////                        recordedValueDict[n] = UserDefaults.standard.dictionary(forKey: recordedKayDict[n]) ?? self.empty_Dictionary
////                    }
////
////                    self.totalDistance_String = UserDefaults.standard.string(forKey: "totalDistance") ?? ""
////
////
//                    let toRecordUD = ["placeType":placeType_String,"practicePoint":practicePoint_String,"mealTime":mealTime_String,"sleepStart":sleepStart_String,"sleepEnd":sleepEnd_String,"tiredLevel":tiredLevel_String,"writing":writing_String]
////
////                    for (key, value) in toRecordDict {
////                        UserDefaults.standard.set(value, forKey: key)
////                    }
////
////                    let menuDictionary = ["team": self.team_Dictionary, "practiceType": self.practiceType_Dictionary, "menu": self.practiceContent_Dictionary, "upDistance": self.upDistance_Dictionary, "downDistance": self.downDistance_Dictionary, "totalDistance": self.totalDistance_String, "upTime": self.upTime_Dictionary, "downTime": self.downTime_Dictionary, "runDetail": self.runDetail_Dictionary] as [String : Any]
////
////                    var dictionary: [String: Any] = [
////                        "yobi": self.todayYobi,
////                        "pain": painDictonary,
////                        "menuBody": menuDictionary
////                    ]
////                    dictionary.merge( toRecordUD ){ (_, new) in new }
////
////
////                    self.runningData_Dictionary.updateValue(dictionary, forKey: self.todayDay)
////
////                    try? await self.db.collection("Users").document(self.userUid).updateData(
////                        [collectionName : self.runningData_Dictionary])
////
////                    var groupRunningData2_Dictionary = try await FirebaseClient.shared.getTodayData(year: todayYear, month: todayMonth, day: todayDay)
////
////                    dictionary.updateValue(self.username, forKey: "username")
////
////                    groupRunningData2_Dictionary.updateValue(dictionary, forKey: "\(self.userUid)")
////                    var groupRunningData_Dictionary = [:]
////                    groupRunningData_Dictionary.updateValue(groupRunningData2_Dictionary, forKey: "\(self.todayYear)-\(self.todayMonth)-\(self.todayDay)")
////
////                    try await self.db.collection("Group").document(self.groupUid).updateData(
////                        ["todayData" : groupRunningData_Dictionary])
////
////                    OtherHost.activityIndicatorView(view: self.view).stopAnimating()
////
////                    UserDefaults.standard.set("\(self.todayYear)/\(self.todayMonth)/\(self.todayDay)", forKey: "checkDay22")
////                    AlertHost.alertDef(view: self, title: "登録完了！", message: "お疲れ様でした！\n今日の練習記録を登録しました！") { _ in
////                        self.performSegue(withIdentifier: "already", sender: self)
////                    }
////
////                    //ここまで
//
//                    let returnValue = try await RecordRunningData.shared.recordData(todayYear: todayYear, todayMonth: todayMonth, todayDay: todayDay, toRecordUD: toRecordUD)
//
//                    OtherHost.activityIndicatorView(view: self.view).stopAnimating()
//
//                    if returnValue {
//                        AlertHost.alertDef(view: self, title: "登録完了！", message: "お疲れ様でした！\n今日の練習記録を登録しました！") { _ in
//                            self.performSegue(withIdentifier: "already", sender: self)
//                        }
//                    } else {
//                        AlertHost.alertDef(view: self, title: "エラー", message: "登録に失敗しました")
//                    }
//                }
//                catch {
//                    print(error.localizedDescription)
//                    AlertHost.alertDef(view: self, title: "エラー", message: "登録に失敗しました:")
//                }
//            }  //Auth
//
//
//
//
//
//
//
//            //↓} :全項目入力有無_if文_1つ目閉じ
//        } else {
//
//            //MARK: if文で一つずつ確認していく
//            var errorType_String = ""
//            var writingError_Detail = ""
//
//            let dict = ["チーム":team_String,"練習場所タイプ":placeType_String,"練習評価":practicePoint_String,"食事の回数":mealTime_String,"睡眠開始時間":sleepStart_String,"睡眠終了時間":sleepEnd_String,"疲労度":tiredLevel_String,"感想":writing_String]
//
//            for (key,value) in dict {
//                if value == "" {
//                    errorType_String = "\(key)が"
//                }
//            }
//
//            if writing_YN == "NO" {
//                errorType_String = "感想が\n十分に"
//                writingError_Detail = "\n感想は25文字以上入力してください。"
//            }
//
//            AlertHost.alertDef(view:self, title: "\(errorType_String)入力されていません", message: "すべての項目を記入後、\n「登録する」ボタンを押してください。\(writingError_Detail)")
//
//        }  //↓} :全項目入力有無_if文_2つ目閉じ
//
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
