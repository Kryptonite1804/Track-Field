//
//  Record-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Record_1_ViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var practice_comment_record: UITextField!
    @IBOutlet weak var up_distance_record: UITextField!
    @IBOutlet weak var main_mene_record: UITableView!
    @IBOutlet weak var down_distance_record: UITextField!
    @IBOutlet weak var total_distance_record: UITextField!
    
    @IBOutlet weak var team_picture: UIImageView!
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var practiceWriting_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var practiceTypeButton: UIButton!
    @IBOutlet weak var upTimeButton: UIButton!
    @IBOutlet weak var downTimeButton: UIButton!
    
    @IBOutlet weak var team_TF: UITextField!
    @IBOutlet weak var practiceType_TF: UITextField!
    @IBOutlet weak var upTime_TF: UITextField!
    @IBOutlet weak var downTime_TF: UITextField!
    
    @IBOutlet weak var practiceKind_SC: UISegmentedControl!

    
    var team_PV = UIPickerView()
    var practiceType_PV = UIPickerView()
    var upTime_PV = UIPickerView()
    var downTime_PV = UIPickerView()
    
    var team_String: String = ""
    var practiceType_String: String = ""
    var practiceContent_String: String = ""
    
    var upDistance_String :String = ""
    var downDistance_String :String = ""
    var totalDistance_String :String = "要編集"
    
    var upTime_String :String = ""
    var downTime_String :String = ""
    
    
    var team_Array = ["A","B","C","D"]
    var practiceType_Array = ["jog","LSD","ペースラン","ビルドアップ","ショートインターバル","ロングインターバル","変化走","刺激","調整","筋トレ","その他"]
    var upTime_Array: [String]! = []
    var downTime_Array: [String]! = []
    var error_Array = ["エラー"]
    
    
//    var aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for m in 0...59 {
            for s in 0...59 {
                var time = ""
                var minute = ""
                var second = ""
                
                if m < 10 {
                    minute = "0\(m)"
                } else {
                    minute = "\(m)"
                }
                
                if s < 10 {
                    second = "0\(s)"
                } else {
                    second = "\(s)"
                }
                
                time = "\(minute):\(second)"
                upTime_Array.append(time)
                downTime_Array.append(time)
            }
        }
        
        
        
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        //PV
        let pvArray = [team_PV,practiceType_PV,upTime_PV,downTime_PV]
        let tfArray = [team_TF,practiceType_TF,upTime_TF,downTime_TF]
        
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
        
        
        //TF
        practice_comment_record.delegate = self
        up_distance_record.delegate = self
        down_distance_record.delegate = self
        
        //TF
        practice_comment_record.tag = 0
        up_distance_record.tag = 1
        down_distance_record.tag = 2
        
        //TF
        practice_comment_record.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        up_distance_record.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        down_distance_record.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
         
        let recordsub = [practiceWriting_picture,team_picture,up_picture,down_picture,total_picture]
        let recordsubCount = recordsub.count
        for n in 0...recordsubCount - 1 {
            let recordsubNum = recordsub[n]
            recordsubNum?.layer.cornerRadius = 5
            recordsubNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            recordsubNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            recordsubNum?.layer.shadowOpacity = 0.25  //影の濃さ
            recordsubNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            recordsubNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            recordsubNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            recordsubNum?.layer.borderWidth = 1.0 // 枠線の太さ
        }
        
        
        practiceKind_SC.selectedSegmentTintColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0) //選択しているボタンの背景色
        practiceKind_SC.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) //選択していないボタンの背景色
        
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected) //選択しているボタンのtextColor
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)], for: .normal) //選択していないボタンのtextColor
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
        practiceContent_String = textField.text!
        print("practicecomment: \(practiceContent_String)")
            
        } else if textField.tag == 1 {
            upDistance_String = textField.text!
            print("updistance: \(upDistance_String)")
            
        } else if textField.tag == 2 {
            downDistance_String = textField.text!
            print("downdistance: \(downDistance_String)")
        }
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
            return team_Array.count
        } else if pickerView.tag == 2 {
            return practiceType_Array.count
        } else if pickerView.tag == 3 {
            return upTime_Array.count
        } else if pickerView.tag == 4 {
            return downTime_Array.count
        } else {
            return error_Array.count
        }
    }
     
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return team_Array[row]
        } else if pickerView.tag == 2 {
            return practiceType_Array[row]
        } else if pickerView.tag == 3 {
            return upTime_Array[row]
        } else if pickerView.tag == 4 {
            return downTime_Array[row]
        } else {
            return error_Array[row]
        }
    }
     
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 処理
        
        if pickerView.tag == 1 {
            team_String = team_Array[row]
            team_TF.text = team_String
        } else if pickerView.tag == 2 {
            practiceType_String = practiceType_Array[row]
            practiceType_TF.text = practiceType_String
        } else if pickerView.tag == 3 {
            upTime_String = upTime_Array[row]
            upTime_TF.text = upTime_String
        } else if pickerView.tag == 4 {
            downTime_String = downTime_Array[row]
            downTime_TF.text = downTime_String
        }
    }
    
        
    @objc func done() {
        self.view.endEditing(true)
    }
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    
    @IBAction func teamtype_record() {
//        aboutButton = teamButton
    }
    
    @IBAction func practictype_record() {
//        aboutButton = practiceTypeButton
    }
    
    @IBAction func up_time_record() {
//        aboutButton = upTimeButton
    }
    
    @IBAction func main_mene_add() {
    }
    
    @IBAction func down_time_record() {
//        aboutButton = downTimeButton
    }
    
    
    //朝練・本練・自主練 選択時
    @IBAction func practiceKind_Selected(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
            case 0: break
                //朝練が選ばれた場合
                
            case 1: break
                //本練が選ばれた場合
                
            case 2: break
                //自主練が選ばれた場合
                
            default: break //break == 何もしない意
                //default値
                
            }
        }
    
    
    
    @IBAction func complete() {
        
        
        //MARK: if文で一つずつ確認していく
        var errorType_String = ""
        
        if team_String != "" && practiceType_String != "" && practiceContent_String != "" && upDistance_String != "" && downDistance_String != "" && totalDistance_String != "" && upTime_String != "" && downTime_String != "" {
            //全て入力済
            
            UserDefaults.standard.set(team_String, forKey: "team")
            UserDefaults.standard.set(practiceType_String, forKey: "practiceType")
            UserDefaults.standard.set(practiceContent_String, forKey: "practiceContent")
            UserDefaults.standard.set(upDistance_String, forKey: "upDistance")
            UserDefaults.standard.set(downDistance_String, forKey: "downDistance")
            UserDefaults.standard.set(totalDistance_String, forKey: "totalDistance")
            UserDefaults.standard.set(upTime_String, forKey: "upTime")
            UserDefaults.standard.set(downTime_String, forKey: "downTime")
            
            self.navigationController?.popViewController(animated: true)
            
        } else {
            //エラー版
            
            if team_String == "" {
                errorType_String = "チーム"
                
            } else if practiceType_String == "" {
                errorType_String = "練習タイプ"
                
            } else if practiceContent_String == "" {
                errorType_String = "メニュー"
                
            } else if upDistance_String == "" {
                errorType_String = "アップの距離"
                
            } else if downDistance_String == "" {
                errorType_String = "ダウンの距離"
                
            } else if totalDistance_String == "" {
                errorType_String = "トータル距離"
                
            } else if upTime_String == "" {
                errorType_String = "アップのタイム"
                
            } else if downTime_String == "" {
                errorType_String = "ダウンのタイム"
                
            }
            
            let alert: UIAlertController = UIAlertController(title: "\(errorType_String)が入力されていません",message: "入力し直しますか？\nメニューの記録をやめて\nトップ画面に戻りますか？", preferredStyle: UIAlertController.Style.alert)
            let confilmAction: UIAlertAction = UIAlertAction(title: "メニューの記録をやめる", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                
                //メニューの記録データを全て ""(値なし) にして前ページへ
                
                UserDefaults.standard.set("", forKey: "team")
                UserDefaults.standard.set("", forKey: "practiceType")
                UserDefaults.standard.set("", forKey: "practiceContent")
                UserDefaults.standard.set("", forKey: "upDistance")
                UserDefaults.standard.set("", forKey: "downDistance")
                UserDefaults.standard.set("", forKey: "totalDistance")
                UserDefaults.standard.set("", forKey: "upTime")
                UserDefaults.standard.set("", forKey: "downTime")
                
                self.navigationController?.popViewController(animated: true)
                
            })
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "入力し直す", style: UIAlertAction.Style.cancel, handler:nil)
            
            alert.addAction(confilmAction)
            alert.addAction(cancelAction)
            
            //alertを表示
                self.present(alert, animated: true, completion: nil)
            
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
