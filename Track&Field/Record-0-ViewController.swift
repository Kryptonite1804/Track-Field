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
    @IBOutlet weak var tiredRevelButton: UIButton!
    
    @IBOutlet weak var placeType_TF: UITextField!
    @IBOutlet weak var practicePoint_TF: UITextField!
    @IBOutlet weak var mealTime_TF: UITextField!
    @IBOutlet weak var sleepStart_TF: UITextField!
    @IBOutlet weak var sleepEnd_TF: UITextField!
    @IBOutlet weak var tiredRevel_TF: UITextField!
    
    
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
    var sleepStart_String: String = ""
    var sleepEnd_String: String = ""
    var tiredRevel_String: String = ""
    var writing_String: String = ""
    
    var painTF_String: String = ""
    var painPlace_String: String = ""
    var painLebel_String: String = ""
    var painWriting_String: String = ""
    
    
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
    
    
    
    var userUid: String = ""
    var groupUid: String = ""
//    var dishesDataSecond_Array: [[String: Any]] = []
    var runningData_Dictionary: [String:Any] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date
        let today = Date()
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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
        painTF_Label.text = painTF_String
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
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
            
            sleepStart_String = sleepStart_Array[row]
            sleepStart_TF.text = sleepStart_String
            print("sleepStart: ",sleepStart_String)
            
        } else if pickerView.tag == 5 {
            
            sleepEnd_String = sleepEnd_Array[row]
            sleepEnd_TF.text = sleepEnd_String
            print("sleepEnd: ",sleepEnd_String)
            
        } else if pickerView.tag == 6 {
            
            tiredRevel_String = tiredRevel_Array[row]
            tiredRevel_TF.text = tiredRevel_String
            print("tiredRevel: ",tiredRevel_String)
            
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
            
            if count < 15 {
                
                print("impression is too short!")
                self.writing_check.image = UIImage(systemName: "exclamationmark.circle.fill")
                self.writing_check.tintColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
                //ピンク - "！"
//                UIImage(named: "frog9")
                
            } else {
                
                print("impression No problem")
                self.writing_check.image = UIImage(systemName: "checkmark.circle.fill")
                self.writing_check.tintColor = .link
                //ブルー - " ✔︎ "
                
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
  scrollViewBottomConstraint.constant = keyboardHeight - 46

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

                            print("runningData_Dictionary: \(self.runningData_Dictionary)")

                            
                            
                            
                            self.painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
//                            self.painPlace_String = UserDefaults.standard.string(forKey: "painPlace") ?? "痛みなし"
                            self.painLebel_String = UserDefaults.standard.string(forKey: "painLebel") ?? ""
                            self.painWriting_String = UserDefaults.standard.string(forKey: "painWriting") ?? ""
                            
                            let painDictonary = ["painTF": self.painTF_String,/* "painPlace": self.painPlace_String,*/ "painLebel": self.painLebel_String, "painWriting": self.painWriting_String]
                            
                            let dictionary: [String: Any] = [
                                "yobi": self.todayYobi,
                                "placeType": self.placeType_String,
                                "practicePoint": self.practicePoint_String,
                                "mealTime": self.mealTime_String,
                                "sleepStart": self.sleepStart_String,
                                "sleepEnd": self.sleepEnd_String,
                                "tiredRevel": self.tiredRevel_String,
                                "writing": self.writing_String,
                                "pain": painDictonary
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
                                    
                                    
                                    self.activityIndicatorView.stopAnimating()
                                    
                                        
                                        //MyAlert
                                        //poptoroot
                                        
                                    let alert: UIAlertController = UIAlertController(title: "登録完了！",message: "お疲れ様でした！\n今日の練習記録を登録しました！", preferredStyle: UIAlertController.Style.alert)
                                    let confilmAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                                        (action: UIAlertAction!) -> Void in
                                        
                                        self.navigationController?.popToRootViewController(animated: true)
                                        
                                    })
                                    
                                    alert.addAction(confilmAction)
                                    
                                    //alertを表示
                                    self.present(alert, animated: true, completion: nil)
                                        
                                    
                                    
                                }
                            }
                                    
                                    
                            
                                    
                                    
                                    
                                    
                            
                            
                            
                        //docRef3
                        } else {
                            print("Document3 does not exist")

                            self.activityIndicatorView.stopAnimating()  //AIV
//                            self.alert(title: "エラー", message: "現在のおかず数の取得に失敗しました5")
                            print("ランニング記録なし")
                            
                        }  //docRef3
                    
            }  //docRef3
            
            
        //docRef2
        } else {
            print("Document2 does not exist")

            self.activityIndicatorView.stopAnimating()  //AIV
            self.alert(title: "エラー", message: "ランニング記録の保存に\n")
        }  //docRef2
    }  //docRef3
            
            
            
        
        }  //Auth
        
        
        
        
        
        
        
        
        
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
