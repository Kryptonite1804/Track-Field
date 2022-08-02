//
//  Record-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Record_1_ViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    
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
    
    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!  //scrollview_キーボード_ずらす
    
    
    var team_PV = UIPickerView()
    var practiceType_PV = UIPickerView()
    var upTime_PV = UIPickerView()
    var downTime_PV = UIPickerView()
    
    
    //TableView
    var runAllData: [String:[String:[String:Any]]] = ["main": [:],"sub": [:],"free": [:]]
    var oneRunDetail: [String:String] = ["distance": "","time": "","pace": ""]
    
    var runningData_Dictionary1: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]] = [:]
    
    var tvTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var tvTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var tvPaceMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var tvPaceSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var lineCount = 1
    
    
    //どのSegumentedControllが選ばれているか
    var selectedSC = "main"
    
    var team_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var practiceType_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var practiceContent_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    
    var upDistance_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var downDistance_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var totalDistance_String :String = "要編集 0000m"
    
    var upTime_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var downTime_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    
    var upTimeHour_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var upTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var upTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var downTimeHour_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var downTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var downTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var team_Array = ["A","B","C","D"]
    var practiceType_Array = ["jog","LSD","ペースラン","ビルドアップ","ショートインターバル","ロングインターバル","変化走","刺激","調整","筋トレ","その他"]
    
    var hourNumber_Array: [String]! = []
    var timeNumber_Array: [String]! = []
    var timeUnit_Array: [String]! = [":"]
    var error_Array = ["エラー"]
    
    
    //    var aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for m in 0...59 {
            var time = ""
            
            if m < 10 {
                time = "0\(m)"
            } else {
                time = "\(m)"
            }
            
            timeNumber_Array.append(time)
            
        }
        
        for n in 0...23 {
            var hour = ""
            
            hour = "\(n)"
            
            hourNumber_Array.append(hour)
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
            
            
            
        }
        
        
        //SC
        practiceKind_SC.selectedSegmentTintColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0) //選択しているボタンの背景色
        practiceKind_SC.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) //選択していないボタンの背景色
        
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected) //選択しているボタンのtextColor
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)], for: .normal) //選択していないボタンのtextColor
        
        
        
        //TV
        main_mene_record.delegate = self
        main_mene_record.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        
        return true //戻り値
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 0 {
            practiceContent_Dictionary[selectedSC] = textField.text!
            print("practicecomment: \(practiceContent_Dictionary[selectedSC]!)")
            
        } else if textField.tag == 1 {
            upDistance_Dictionary[selectedSC] = textField.text!
            print("updistance: \(upDistance_Dictionary[selectedSC]!)")
            
        } else if textField.tag == 2 {
            downDistance_Dictionary[selectedSC] = textField.text!
            print("downdistance: \(downDistance_Dictionary[selectedSC]!)")
        }
        
        //tableView - runDetail
        else if textField.tag >= 100 && textField.tag < 200 {
            
            oneRunDetail = runAllData[selectedSC]?["\(textField.tag - 100)"] as? [String:String] ?? ["distance": "","time": "","pace": ""]
            //距離
            oneRunDetail["distance"] = textField.text!
            print("row: \(textField.tag - 100)\ndistance: \(oneRunDetail["distance"]!)")
            
            
            let paceCheck = oneRunDetail["pace"] ?? "データなし"
            
            if paceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "pace")
            }
            
            let timeCheck = oneRunDetail["time"] ?? "データなし"
            
            if timeCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "time")
            }
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(textField.tag - 100)")
            print("distance - changed",runAllData[selectedSC]!)
            
        }
    }
    
    //PV
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 3 {
            
            return 5
            
        } else if pickerView.tag == 4 {
            
            return 5
            
        } else if pickerView.tag >= 400 && pickerView.tag < 500 {
            
            return 3
            
        } else if pickerView.tag >= 500 && pickerView.tag < 600 {
            
            return 3
            
            
        } else {
            
            return 1
            
        }
        
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 1 {
            return team_Array.count
        } else if pickerView.tag == 2 {
            return practiceType_Array.count
        } else if pickerView.tag == 3 {
            
            switch component {
            case 0:
                return hourNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return timeNumber_Array.count
            case 3:
                return timeUnit_Array.count
            case 4:
                return timeNumber_Array.count
            default:
                return 0
            }
            
        } else if pickerView.tag == 4 {
            
            switch component {
            case 0:
                return hourNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return timeNumber_Array.count
            case 3:
                return timeUnit_Array.count
            case 4:
                return timeNumber_Array.count
            default:
                return 0
            }
            
            //~TV
        } else if pickerView.tag >= 400 && pickerView.tag < 500 {
            
            switch component {
            case 0:
                return timeNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return timeNumber_Array.count
            default:
                return 0
            }
            
        } else if pickerView.tag >= 500 && pickerView.tag < 600 {
            
            switch component {
            case 0:
                return timeNumber_Array.count
            case 1:
                return timeUnit_Array.count
            case 2:
                return timeNumber_Array.count
            default:
                return 0
            }
            
            //~TV
            
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
            
            switch component {
            case 0:
                return hourNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return timeNumber_Array[row]
            case 3:
                return timeUnit_Array[row]
            case 4:
                return timeNumber_Array[row]
            default:
                return "error"
            }
            
        } else if pickerView.tag == 4 {
            
            switch component {
            case 0:
                return hourNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return timeNumber_Array[row]
            case 3:
                return timeUnit_Array[row]
            case 4:
                return timeNumber_Array[row]
            default:
                return "error"
            }
            
            //TV~
        } else if pickerView.tag >= 400 && pickerView.tag < 500 {
            
            switch component {
            case 0:
                return timeNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return timeNumber_Array[row]
            default:
                return "error"
            }
            
        } else if  pickerView.tag >= 500 && pickerView.tag < 600 {
            
            switch component {
            case 0:
                return timeNumber_Array[row]
            case 1:
                return timeUnit_Array[row]
            case 2:
                return timeNumber_Array[row]
            default:
                return "error"
            }
            //~TV
            
        } else {
            return error_Array[row]
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 処理
        
        if pickerView.tag == 1 {
            team_Dictionary[selectedSC] = team_Array[row]
            team_TF.text = team_Dictionary[selectedSC]
            
        } else if pickerView.tag == 2 {
            practiceType_Dictionary[selectedSC] = practiceType_Array[row]
            practiceType_TF.text = practiceType_Dictionary[selectedSC]
            
        } else if pickerView.tag == 3 {
            
            switch component {
            case 0:
                upTimeHour_Dictionary[selectedSC] = hourNumber_Array[row]
            case 2:
                upTimeMinute_Dictionary[selectedSC] = timeNumber_Array[row]
            case 4:
                upTimeSecond_Dictionary[selectedSC] = timeNumber_Array[row]
                
            default:
                break
            }
            
            upTime_Dictionary[selectedSC] = "\(upTimeHour_Dictionary[selectedSC]!):\(upTimeMinute_Dictionary[selectedSC]!):\(upTimeSecond_Dictionary[selectedSC]!)"
            upTime_TF.text = upTime_Dictionary[selectedSC]
            
        } else if pickerView.tag == 4 {
            
            switch component {
            case 0:
                downTimeHour_Dictionary[selectedSC] = hourNumber_Array[row]
            case 2:
                downTimeMinute_Dictionary[selectedSC] = timeNumber_Array[row]
            case 4:
                downTimeSecond_Dictionary[selectedSC] = timeNumber_Array[row]
            default:
                break
            }
            
            downTime_Dictionary[selectedSC] = "\(downTimeHour_Dictionary[selectedSC]!):\(downTimeMinute_Dictionary[selectedSC]!):\(downTimeSecond_Dictionary[selectedSC]!)"
            downTime_TF.text = downTime_Dictionary[selectedSC]
        }
        
        //TV~
        
        else if pickerView.tag >= 400 && pickerView.tag < 500 {
            
            switch component {
            case 0:
                tvTimeMinute_Dictionary[selectedSC] = timeNumber_Array[row]
            case 2:
                tvTimeSecond_Dictionary[selectedSC] = timeNumber_Array[row]
            default:
                break
            }
            
            //            runAllData[selectedSC]!["\(pickerView.tag - 400)"]!["time"] = "\(tvTimeMinute_Dictionary[selectedSC]!):\(tvTimeSecond_Dictionary[selectedSC]!)"
            //            main_mene_record.reloadData()
            oneRunDetail = runAllData[selectedSC]?["\(pickerView.tag - 400)"] as? [String:String] ?? ["distance": "","time": "","pace": ""]
            
            oneRunDetail["time"] = "\(tvTimeMinute_Dictionary[selectedSC]!):\(tvTimeSecond_Dictionary[selectedSC]!)"
            
            print("row: \(pickerView.tag - 400)\npace: \(oneRunDetail["time"]!)")
            
            let distanceCheck = oneRunDetail["distance"] ?? "データなし"
            
            if distanceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "distance")
            }
            
            let paceCheck = oneRunDetail["pace"] ?? "データなし"
            
            if paceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "pace")
            }
            
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(pickerView.tag - 400)")
            print("time - changed",runAllData[selectedSC]!)
            
            print("ここからですよ",runAllData)
            
            main_mene_record.reloadData()
            
            
        } else if pickerView.tag >= 500 && pickerView.tag < 600 {
            
            switch component {
            case 0:
                tvPaceMinute_Dictionary[selectedSC] = timeNumber_Array[row]
            case 2:
                tvPaceSecond_Dictionary[selectedSC] = timeNumber_Array[row]
            default:
                break
            }
            
            //           runAllData = [selectedSC:["\(pickerView.tag - 500)":["pace": "\(tvPaceMinute_Dictionary[selectedSC]!):\(tvPaceSecond_Dictionary[selectedSC]!)"]]]
            
            oneRunDetail = runAllData[selectedSC]?["\(pickerView.tag - 500)"] as? [String:String] ?? ["distance": "","time": "","pace": ""]
            oneRunDetail["pace"] = "\(tvPaceMinute_Dictionary[selectedSC]!):\(tvPaceSecond_Dictionary[selectedSC]!)"
            
            print("row: \(pickerView.tag - 500)\npace: \(oneRunDetail["pace"]!)")
            
            
            let distanceCheck = oneRunDetail["distance"] ?? "データなし"
            
            if distanceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "distance")
            }
            
            let timeCheck = oneRunDetail["time"] ?? "データなし"
            
            if timeCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "time")
            }
            
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(pickerView.tag - 500)")
            print("pace - changed",runAllData[selectedSC]!)
            
            
            print("ここからですよ",runAllData)
            
            main_mene_record.reloadData()
            
        }
        //~TV
        
        
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
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if runningData_Dictionary1.count == 0 {
            return lineCount
        } else {
            
            if lineCount > runningData_Dictionary1.count {
                
                return lineCount
                
            } else {
                
            return self.runningData_Dictionary1.count
                
            }
        }
        
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Record_1_TableViewCell
        
        cell.distance_TF?.delegate = self
        //        cell.time_TF?.delegate = self
        //        cell.pace_TF?.delegate = self
        
        
        cell.distance_TF?.tag = 100
        //        cell.time_TF?.tag = 200
        //        cell.pace_TF?.tag = 300
        
        cell.distance_TF?.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        //        cell.time_TF?.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        //        cell.pace_TF?.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        runningData_Dictionary1 = runAllData[selectedSC]!
        runningData_Dictionary2 = runningData_Dictionary1 as! [String:[String:Any]]
        
        cell.distance_TF?.text = runningData_Dictionary2["\(indexPath.row)"]?["distance"] as? String ?? ""
        cell.time_TF?.text = runningData_Dictionary2["\(indexPath.row)"]?["time"] as? String ?? ""
        cell.pace_TF?.text = runningData_Dictionary2["\(indexPath.row)"]?["pace"] as? String ?? ""
        
        
        //Toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        //PV
        
        cell.timeTableView_PV.delegate = self
        cell.timeTableView_PV.dataSource = self
        cell.time_TF.inputView = cell.timeTableView_PV
        cell.time_TF.inputAccessoryView = toolbar
        cell.timeTableView_PV.tag = 400 + indexPath.row
        
        cell.time_TF?.tintColor = UIColor.clear
        
        cell.paceTableView_PV.delegate = self
        cell.paceTableView_PV.dataSource = self
        cell.pace_TF.inputView = cell.paceTableView_PV
        cell.pace_TF.inputAccessoryView = toolbar
        cell.paceTableView_PV.tag = 500 + indexPath.row
        
        //            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
        
        return cell  //cellの戻り値を設定
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
    
    @IBAction func runDetail_Add() {
        
        if runningData_Dictionary1.count == 0 {
            
            lineCount += 1
            
        } else {
            
            oneRunDetail = runAllData[selectedSC]?["\(runAllData[selectedSC]!.count - 1)"] as? [String:String] ?? ["distance": "","time": "","pace": ""]
            
            let paceCheck = oneRunDetail["pace"] ?? "データなし"
            
            if paceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "pace")
            }
            
            let timeCheck = oneRunDetail["time"] ?? "データなし"
            
            if timeCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "time")
            }
            
            let distanceCheck = oneRunDetail["distance"] ?? "データなし"
            
            if distanceCheck == "データなし" {
                //データなしのため、oneRunDetailに"distance":""を追加
                oneRunDetail.updateValue("", forKey: "distance")
            }
        
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(runAllData[selectedSC]!.count)")
            
        }
        main_mene_record.reloadData()
        
    }
    
    @IBAction func down_time_record() {
        //        aboutButton = downTimeButton
    }
    
    
    //朝練・本練・自主練 選択時
    @IBAction func practiceKind_Selected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //朝練が選ばれた場合
            selectedSC = "sub"
            
        case 1:
            //本練が選ばれた場合
            selectedSC = "main"
            
        case 2:
            //自主練が選ばれた場合
            selectedSC = "free"
            
        default: break //break == 何もしない意
            //default値
            
        }
        
        team_TF.text = team_Dictionary[selectedSC]
        practiceType_TF.text = practiceType_Dictionary[selectedSC]
        upTime_TF.text = upTime_Dictionary[selectedSC]
        downTime_TF.text = downTime_Dictionary[selectedSC]
        
        practice_comment_record.text = practiceContent_Dictionary[selectedSC]
        up_distance_record.text = upDistance_Dictionary[selectedSC]
        down_distance_record.text = downDistance_Dictionary[selectedSC]
        
        runningData_Dictionary1 = runAllData[selectedSC]!
        main_mene_record.reloadData()
        
    }
    
    
    
    @IBAction func complete() {
        var check_Dictionary = ["main":"YES","sub":"YES","free":"YES"]
        var check_String = "NONE"
        let SCKind_Array = ["main","sub","free"]
        var SCKind_String = ""
        var SCKindJP_String = ""
        var checksecond = "YES"
        
        
        var errorType_String = ""
        
        for n in 0...2 {
            
            SCKind_String = SCKind_Array[n]
            
            if team_Dictionary[SCKind_String] == "" && practiceType_Dictionary[SCKind_String] == "" && practiceContent_Dictionary[SCKind_String] == "" && upDistance_Dictionary[SCKind_String] == "" && downDistance_Dictionary[SCKind_String] == "" &&/* totalDistance_String == "" &&*/ upTime_Dictionary[SCKind_String] == "" && downTime_Dictionary[SCKind_String] == "" {
                //MARK: TOTALDISTANCE 要注意・編集
                //すべて入力されていない
                //この場合このSCは飛ばし
                
                
                
            } else {
                
                //                check_String = "GO"
                
                func SCKindJP() {
                    
                    if SCKind_String == "main" {
                        SCKindJP_String = "本練習"
                    } else if SCKind_String == "sub" {
                        SCKindJP_String = "朝練"
                        
                    } else if SCKind_String == "free" {
                        SCKindJP_String = "自主練習"
                    }
                    
                }
                
                
                
                if team_Dictionary[SCKind_String] == "" {
                    errorType_String = "チームの"
                    check_Dictionary[SCKind_String] = "NO"
                    SCKindJP()
                    
                } else if practiceType_Dictionary[SCKind_String] == "" {
                    errorType_String = "練習タイプの"
                    check_Dictionary[SCKind_String] = "NO"
                    SCKindJP()
                    
                } else if practiceContent_Dictionary[SCKind_String] == "" {
                    errorType_String = "メニューの"
                    check_Dictionary[SCKind_String] = "NO"
                    SCKindJP()
                    
                } else if upDistance_Dictionary[SCKind_String] == "" {
                    errorType_String = "アップの距離の"
                    check_Dictionary[SCKind_String] = "NO"
                    SCKindJP()
                    
                } else if downDistance_Dictionary[SCKind_String] == "" {
                    errorType_String = "ダウンの距離の"
                    check_Dictionary[SCKind_String] = "NO"
                    SCKindJP()
                    
                }/* else if totalDistance_String == "" {
                  errorType_String = "トータル距離"
                  
                  }*/ else if upTime_Dictionary[SCKind_String] == "" {
                      errorType_String = "アップのタイムの"
                      check_Dictionary[SCKind_String] = "NO"
                      SCKindJP()
                      
                  } else if downTime_Dictionary[SCKind_String] == "" {
                      errorType_String = "ダウンのタイムの"
                      check_Dictionary[SCKind_String] = "NO"
                      SCKindJP()
                      
                  } else {
                      
                      //いずれかひとつのSC完全入力済
                      check_Dictionary[SCKind_String] = "YES"
                      
                      
                  }
                
                
            }
            
            
        }
        
        
        for m in 0...2 {
            SCKind_String = SCKind_Array[m]
            
            if check_String == "YES" || check_String == "NONE" {
                
                checksecond = check_Dictionary[SCKind_String]!
                
                
                if checksecond == "YES" {
                    //pass
                    check_String = "YES"
                    
                } else if checksecond == "NO" {
                    //入力漏れあり
                    check_String = "NO"
                }
                
            }
            
        }
        
        
        
        
        if check_String == "YES" {
            
            //いずれかのSCが完璧に入力済
            
            //いずれかひとつのSCが全て入力済
            
            UserDefaults.standard.set(team_Dictionary, forKey: "team")
            UserDefaults.standard.set(practiceType_Dictionary, forKey: "practiceType")
            UserDefaults.standard.set(practiceContent_Dictionary, forKey: "menu")
            UserDefaults.standard.set(upDistance_Dictionary, forKey: "upDistance")
            UserDefaults.standard.set(downDistance_Dictionary, forKey: "downDistance")
            UserDefaults.standard.set(totalDistance_String, forKey: "totalDistance")
            UserDefaults.standard.set(upTime_Dictionary, forKey: "upTime")
            UserDefaults.standard.set(downTime_Dictionary, forKey: "downTime")
            UserDefaults.standard.set(runAllData, forKey: "runDetail")
            
            
            
            self.navigationController?.popViewController(animated: true)
            
            
            
            
        } else if check_String == "NO" {
            
            //エラー版
            
            let alert: UIAlertController = UIAlertController(title: "\(SCKindJP_String)の\(errorType_String)記録に\n記入漏れがあるようです",message: "保存するには、\n朝練・本練・自主練習のいずれかを\n完全に入力する必要があります。\nメニューの記録をやめて\nトップ画面に戻りますか？", preferredStyle: UIAlertController.Style.alert)
            let confilmAction: UIAlertAction = UIAlertAction(title: "メニューの記録をやめる", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                
                //メニューの記録データを全て ""(値なし) にして前ページへ
                
                UserDefaults.standard.removeObject(forKey: "team")
                UserDefaults.standard.removeObject(forKey: "practiceType")
                UserDefaults.standard.removeObject(forKey: "practiceContent")
                UserDefaults.standard.removeObject(forKey: "upDistance")
                UserDefaults.standard.removeObject(forKey: "downDistance")
                UserDefaults.standard.removeObject(forKey: "totalDistance")
                UserDefaults.standard.removeObject(forKey: "upTime")
                UserDefaults.standard.removeObject(forKey: "downTime")
                UserDefaults.standard.removeObject(forKey: "runDetail")
                
                self.navigationController?.popViewController(animated: true)
                
            })
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "入力し直す", style: UIAlertAction.Style.cancel, handler:nil)
            
            alert.addAction(confilmAction)
            alert.addAction(cancelAction)
            
            //alertを表示
            self.present(alert, animated: true, completion: nil)
            
        } else if check_String == "NONE" {
            
            //エラー版
            
            let alert: UIAlertController = UIAlertController(title: "すべての情報が\n入力されていません",message: "保存するには、\n朝練・本練・自主練習のいずれかを\n完全に入力する必要があります。\nメニューの記録をやめて\nトップ画面に戻りますか？", preferredStyle: UIAlertController.Style.alert)
            let confilmAction: UIAlertAction = UIAlertAction(title: "メニューの記録をやめる", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                
                //メニューの記録データを全て ""(値なし) にして前ページへ
                
                UserDefaults.standard.removeObject(forKey: "team")
                UserDefaults.standard.removeObject(forKey: "practiceType")
                UserDefaults.standard.removeObject(forKey: "practiceContent")
                UserDefaults.standard.removeObject(forKey: "upDistance")
                UserDefaults.standard.removeObject(forKey: "downDistance")
                UserDefaults.standard.removeObject(forKey: "totalDistance")
                UserDefaults.standard.removeObject(forKey: "upTime")
                UserDefaults.standard.removeObject(forKey: "downTime")
                UserDefaults.standard.removeObject(forKey: "runDetail")
                
                self.navigationController?.popViewController(animated: true)
                
            })
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "入力し直す", style: UIAlertAction.Style.cancel, handler:nil)
            
            alert.addAction(confilmAction)
            alert.addAction(cancelAction)
            
            //alertを表示
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    //MARK: if文で一つずつ確認していく
    //        var errorType_String = ""
    //
    //        if team_String != "" && practiceType_String != "" && practiceContent_String != "" && upDistance_String != "" && downDistance_String != "" && totalDistance_String != "" && upTime_String != "" && downTime_String != "" {
    //            //全て入力済
    //
    //            UserDefaults.standard.set(team_String, forKey: "team")
    //            UserDefaults.standard.set(practiceType_String, forKey: "practiceType")
    //            UserDefaults.standard.set(practiceContent_String, forKey: "practiceContent")
    //            UserDefaults.standard.set(upDistance_String, forKey: "upDistance")
    //            UserDefaults.standard.set(downDistance_String, forKey: "downDistance")
    //            UserDefaults.standard.set(totalDistance_String, forKey: "totalDistance")
    //            UserDefaults.standard.set(upTime_String, forKey: "upTime")
    //            UserDefaults.standard.set(downTime_String, forKey: "downTime")
    //
    //            self.navigationController?.popViewController(animated: true)
    //
    //        } else {
    //            //エラー版
    //
    //            if team_String == "" {
    //                errorType_String = "チーム"
    //
    //            } else if practiceType_String == "" {
    //                errorType_String = "練習タイプ"
    //
    //            } else if practiceContent_String == "" {
    //                errorType_String = "メニュー"
    //
    //            } else if upDistance_String == "" {
    //                errorType_String = "アップの距離"
    //
    //            } else if downDistance_String == "" {
    //                errorType_String = "ダウンの距離"
    //
    //            } else if totalDistance_String == "" {
    //                errorType_String = "トータル距離"
    //
    //            } else if upTime_String == "" {
    //                errorType_String = "アップのタイム"
    //
    //            } else if downTime_String == "" {
    //                errorType_String = "ダウンのタイム"
    //
    //            }
    //
    //            let alert: UIAlertController = UIAlertController(title: "\(errorType_String)が入力されていません",message: "入力し直しますか？\nメニューの記録をやめて\nトップ画面に戻りますか？", preferredStyle: UIAlertController.Style.alert)
    //            let confilmAction: UIAlertAction = UIAlertAction(title: "メニューの記録をやめる", style: UIAlertAction.Style.default, handler:{
    //                (action: UIAlertAction!) -> Void in
    //
    //                //メニューの記録データを全て ""(値なし) にして前ページへ
    //
    //                UserDefaults.standard.set("", forKey: "team")
    //                UserDefaults.standard.set("", forKey: "practiceType")
    //                UserDefaults.standard.set("", forKey: "practiceContent")
    //                UserDefaults.standard.set("", forKey: "upDistance")
    //                UserDefaults.standard.set("", forKey: "downDistance")
    //                UserDefaults.standard.set("", forKey: "totalDistance")
    //                UserDefaults.standard.set("", forKey: "upTime")
    //                UserDefaults.standard.set("", forKey: "downTime")
    //
    //                self.navigationController?.popViewController(animated: true)
    //
    //            })
    //
    //            let cancelAction: UIAlertAction = UIAlertAction(title: "入力し直す", style: UIAlertAction.Style.cancel, handler:nil)
    //
    //            alert.addAction(confilmAction)
    //            alert.addAction(cancelAction)
    //
    //            //alertを表示
    //            self.present(alert, animated: true, completion: nil)
    //
    //        }
    
    
}




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


