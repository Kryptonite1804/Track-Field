//
//  Analize-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit

class Analize_0_ViewController: UIViewController/*, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource*/ {

    @IBOutlet weak var startday_check: UIImageView!
    @IBOutlet weak var endday_check: UIImageView!
    @IBOutlet weak var graph_key1_check: UIImageView!
    @IBOutlet weak var graph_key2_check: UIImageView!
    
    @IBOutlet weak var startday_picture: UIImageView!
    @IBOutlet weak var endday_picture: UIImageView!
    @IBOutlet weak var graphKey1_picture: UIImageView!
    @IBOutlet weak var graphKey2_picture: UIImageView!
    
    @IBOutlet var startDate_DatePicker: UIDatePicker!
    @IBOutlet var endDate_DatePicker: UIDatePicker!

    @IBOutlet weak var element1_Button: UIButton!
    @IBOutlet weak var element2_Button: UIButton!
    
    @IBOutlet weak var element1_Label: UILabel!
    @IBOutlet weak var element2_Label: UILabel!
    
    @IBOutlet weak var element1_None_Label: UILabel!
    @IBOutlet weak var element2_None_Label: UILabel!
    
//
//    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!  //scrollview_キーボード_ずらす
    
//    var element1_PV = UIPickerView()
//    var element2_PV = UIPickerView()
//
    var element1_String: String = ""
    var element2_String: String = ""
    
    var element1_Kind_String: String = ""
    var element2_Kind_String: String = ""
    
    
    
//    var element1_Array = ["曜日","練習場所タイプ","練習評価","痛みの有無","痛みの度合い","食事の回数","睡眠時間","疲労度","チーム","練習タイプ","アップの距離","ダウンの距離","アップのタイム","ダウンのタイム","トータル距離"]
//    var element2_Array = ["曜日","練習場所タイプ","練習評価","痛みの有無","痛みの度合い","食事の回数","睡眠時間","疲労度","チーム","練習タイプ","アップの距離","ダウンの距離","アップのタイム","ダウンのタイム","トータル距離"]
//
//    var error_Array = ["エラー"]
    
    let date_Formatter = DateFormatter()  //DP
    
    var startDate_String: String = ""
    var endDate_String: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startday_picture.layer.cornerRadius = 20
        startday_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        startday_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        startday_picture.layer.shadowOpacity = 0.25  //影の濃さ
        startday_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        startday_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        endday_picture.layer.cornerRadius = 20
        endday_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        endday_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        endday_picture.layer.shadowOpacity = 0.25  //影の濃さ
        endday_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        endday_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        graphKey1_picture.layer.cornerRadius = 20
        graphKey1_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        graphKey1_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        graphKey1_picture.layer.shadowOpacity = 0.25  //影の濃さ
        graphKey1_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphKey1_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        graphKey2_picture.layer.cornerRadius = 20
        graphKey2_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        graphKey2_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        graphKey2_picture.layer.shadowOpacity = 0.25  //影の濃さ
        graphKey2_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphKey2_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        
        
        //Toolbar
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PV
//        let pvArray = [element1_PV,element2_PV]
//        let tfArray = [element1_TF,element1_TF]
//
//        for n in 0...pvArray.count - 1 {
//
//            let pv = pvArray[n]
//            let tf = tfArray[n]
//
//            pv.delegate = self
//            pv.dataSource = self
//            tf?.inputView = pv
//            tf?.inputAccessoryView = toolbar
//            pv.tag = n + 1
//
//            tf?.tintColor = UIColor.clear
//        }
        
        //sleepStartTime_Picker初期値
//        sleepStart_PV.selectRow(12, inComponent: 0, animated: false)
        
        
        
        //DP
        date_Formatter.dateFormat = "yyyy/MM/dd"
        
        startDate_DatePicker.datePickerMode = UIDatePicker.Mode.date
        startDate_DatePicker.timeZone = NSTimeZone.local
        startDate_DatePicker.locale = Locale.current
        startDate_DatePicker.endEditing(true)
        
        endDate_DatePicker.datePickerMode = UIDatePicker.Mode.date
        endDate_DatePicker.timeZone = NSTimeZone.local
        endDate_DatePicker.locale = Locale.current
        endDate_DatePicker.endEditing(true)
        
        startDate_DatePicker.maximumDate = NSDate() as Date
        endDate_DatePicker.maximumDate = NSDate() as Date
        
        UserDefaults.standard.set("", forKey: "element1_value")
        UserDefaults.standard.set("", forKey: "element2_value")
        UserDefaults.standard.set("", forKey: "element1_kind")
        UserDefaults.standard.set("", forKey: "element2_kind")
        
        
        //scrollview_キーボード_ずらす
//        NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(keyboardWillChangeFrame),
//                                                   name: UIResponder.keyboardWillShowNotification,
//                                                   object: nil)
//        NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(keyboardWillHide),
//                                                   name: UIResponder.keyboardWillHideNotification,
//                                                   object: nil)
        //scrollview_キーボード_ずらす
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let elementcheck = UserDefaults.standard.string(forKey: "elementCheck") ?? ""
        
        element1_String = UserDefaults.standard.string(forKey: "element1_value") ?? ""
        element2_String = UserDefaults.standard.string(forKey: "element2_value") ?? ""
        element1_Kind_String = UserDefaults.standard.string(forKey: "element1_kind") ?? ""
        element2_Kind_String = UserDefaults.standard.string(forKey: "element2_kind") ?? ""
        
        print("elementcheck",elementcheck)
        print("element1_String",element1_String)
        print("element2_String",element2_String)
        print("element1_kind",element1_Kind_String)
        print("element2_kind",element2_Kind_String)
        
//        if element1_String != "" && element1_String == element2_String {
//
//            alert(title: "同じ要素は選べません", message: "要素1と要素2で同じ要素が選択されたようです。\n同じ要素でグラフを作成することはできません。\n違う要素を選択し直してください。")
//
//        } else {
            
            if elementcheck == "element1" {
                
                element1_Label.text = element1_String
                
                print("通ったよ")
                
            } else if elementcheck == "element2" {
                
                element2_Label.text = element2_String
                print("通ったお")
            }
            
            
            
            UserDefaults.standard.set("", forKey: "elementCheck")
//            UserDefaults.standard.set("", forKey: "element1_value")
//            UserDefaults.standard.set("", forKey: "element2_value")
//            UserDefaults.standard.set("", forKey: "element1_kind")
//            UserDefaults.standard.set("", forKey: "element2_kind")
//        }
        
        if element1_String == "" {
            element1_Label.isHidden = true
            element1_None_Label.isHidden = false
        } else {
            element1_Label.isHidden = false
            element1_None_Label.isHidden = true
        }
        
        if element2_String == "" {
            element2_Label.isHidden = true
            element2_None_Label.isHidden = false
        } else {
            element2_Label.isHidden = false
            element2_None_Label.isHidden = true
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
    
    
    
    //PV
    // UIPickerViewの列の数
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//
//            return 1
//
//    }
    
    
    
    // UIPickerViewの行数、要素の全数
//    func pickerView(_ pickerView: UIPickerView,
//                    numberOfRowsInComponent component: Int) -> Int {
//
//        if pickerView.tag == 1 {
//            return element1_Array.count
//        } else if pickerView.tag == 2 {
//            return element2_Array.count
//        } else {
//            return error_Array.count
//        }
//
//    }
    
    
    
    // UIPickerViewに表示する配列
//    func pickerView(_ pickerView: UIPickerView,
//                    titleForRow row: Int,
//                    forComponent component: Int) -> String? {
//
//        if pickerView.tag == 1 {
//            return element1_Array[row]
//        } else if pickerView.tag == 2 {
//            return element2_Array[row]
//        } else {
//            return error_Array[row]
//        }
//    }
    
    
    
    // UIPickerViewのRowが選択された時の挙動
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // 処理
//
//        if pickerView.tag == 1 {
//
//            element1_String = element1_Array[row]
//            element1_TF.text = element1_String
//            print("placeType: ",element1_String)
//
//        } else if pickerView.tag == 2 {
//
//            element2_String = element2_Array[row]
//            element2_TF.text = element2_String
//            print("practicePoint: ",element2_String)
//
//        }
//
//    }
//
//
//
//    @objc func done() {
//        self.view.endEditing(true)
//    }
//
    
    //scrollview_キーボード_ずらす_ここから
//    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
//        print("キーボード表示")
//
//        //キーボードのサイズ
//  guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
//        //キーボードのアニメーション時間
//        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
//        //キーボードのアニメーション曲線
//        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
//        //Outletで結び付けたScrollViewのBottom制約
//        let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }
//
//  //キーボードの高さ
//  let keyboardHeight = keyboardFrame.height
//  //Bottom制約再設定
//  scrollViewBottomConstraint.constant = keyboardHeight - 93
//
//  //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
//  UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
//    self.view.layoutIfNeeded()
//  })
//      }
//
//
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        print("キーボード非表示")
//
//        //キーボードのアニメーション時間
//            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
//                  //キーボードのアニメーション曲線
//                  let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
//                  //Outletで結び付けたScrollViewのBottom制約
//                  let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }
//
//            //画面いっぱいになるのでBottomのマージンを0に戻す
//            scrollViewBottomConstraint.constant = 0
//
//            //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
//            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
//              self.view.layoutIfNeeded()
//            })
//
//
//      }
    
    //scrollview_キーボード_ずらす_ここまで
    
    
    
    
    @IBAction func graph_key1() {
        UserDefaults.standard.set("element1", forKey: "elementCheck")
        self.performSegue(withIdentifier: "go-ana-2", sender: self)
    }
    
    @IBAction func graph_key2() {
        UserDefaults.standard.set("element2", forKey: "elementCheck")
        self.performSegue(withIdentifier: "go-ana-2", sender: self)
    }
    
    @IBAction func startDate_DP_Tapped() {
        
        startDate_String = date_Formatter.string(from: startDate_DatePicker.date)
        print("開始日時設定: \(startDate_String)")
        
        let startDate_Date = date_Formatter.date(from: startDate_String)
        endDate_DatePicker.minimumDate = startDate_Date
        
    }
    
    @IBAction func endDate_DP_Tapped() {
        
        
        endDate_String = date_Formatter.string(from: endDate_DatePicker.date)
        print("終了日時設定: \(endDate_String)")
        
        let endDate_Date = date_Formatter.date(from: endDate_String)
        startDate_DatePicker.maximumDate = endDate_Date
        
    }
    
    
    
    @IBAction func make_graph() {
        //グラフの日付・要素確認
        
        self.performSegue(withIdentifier: "go-ana_1", sender: self)
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
