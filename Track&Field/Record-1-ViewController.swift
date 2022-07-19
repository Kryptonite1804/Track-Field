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

    
    var team_PV = UIPickerView()
    var practiceType_PV = UIPickerView()
    var upTime_PV = UIPickerView()
    var downTime_PV = UIPickerView()
    
    var practice_comment :String = ""
    var up_distance :String = ""
    var down_distance :String = ""
    
    
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
        
         
        let recordsub = [team_picture,practiceWriting_picture,up_picture,down_picture,total_picture]
        let recordsubCount = recordsub.count
        for n in 0...recordsubCount-1 {
            let recordsubNum = recordsub[n]
            team_picture.layer.cornerRadius = 5
            team_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            team_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
            team_picture.layer.shadowOpacity = 0.25  //影の濃さ
            team_picture.layer.shadowRadius = 4.0 // 影のぼかし量
            team_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            team_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            team_picture.layer.borderWidth = 1.0 // 枠線の太さ
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
        practice_comment = textField.text!
        print("practicecomment: \(practice_comment)")
            
        } else if textField.tag == 1 {
            up_distance = textField.text!
            print("updistance: \(up_distance)")
            
        } else if textField.tag == 2 {
            down_distance = textField.text!
            print("downdistance: \(down_distance)")
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
            team_TF.text = team_Array[row]
        } else if pickerView.tag == 2 {
            practiceType_TF.text = practiceType_Array[row]
        } else if pickerView.tag == 3 {
            upTime_TF.text = upTime_Array[row]
        } else if pickerView.tag == 4 {
            downTime_TF.text = downTime_Array[row]
        }
    }
    
        
    @objc func done() {
        self.view.endEditing(true)
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
    
    @IBAction func complete() {
        self.navigationController?.popViewController(animated: true)
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
