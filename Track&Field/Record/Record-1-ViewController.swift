//
//  Record-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import SafariServices

class Record_1_ViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource, SFSafariViewControllerDelegate {
    
    
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
    @IBOutlet weak var complete_picture: UIImageView!
    
    
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
    
    @IBOutlet weak var scrollView_Const: NSLayoutConstraint!
    
    
    
    var team_PV = UIPickerView()
    var practiceType_PV = UIPickerView()
    var upTime_PV = UIPickerView()
    var downTime_PV = UIPickerView()
    
    
    //TableView
    var runAllData: [String:[String:[String:Any]]] = ["main": ["0":["distance": "","time": "","pace": ""]],"sub": ["0":["distance": "","time": "","pace": ""]],"free": ["0":["distance": "","time": "","pace": ""]]]
    var oneRunDetail: [String:String] = ["distance": "","time": "","pace": ""]
    
    var runningData_Dictionary1: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]] = [:]
    
    var tvTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var tvTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var tvPaceMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var tvPaceSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    //    var lineCount = 1
    
    
    //どのSegumentedControllが選ばれているか
    var selectedSC = "main"
    
    var team_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var practiceType_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    var practiceContent_Dictionary: Dictionary = ["main": "", "sub":"", "free":""]
    
    var upDistance_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var downDistance_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var totalDistance_String :String = "0"
    
    var upTime_Dictionary: Dictionary = ["main": "0:00:00", "sub":"0:00:00", "free":"0:00:00"]
    var downTime_Dictionary: Dictionary = ["main": "0:00:00", "sub":"0:00:00", "free":"0:00:00"]
    
    var upTimeHour_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var upTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var upTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var downTimeHour_Dictionary: Dictionary = ["main": "0", "sub":"0", "free":"0"]
    var downTimeMinute_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    var downTimeSecond_Dictionary: Dictionary = ["main": "00", "sub":"00", "free":"00"]
    
    var team_Array = ["- - -","A","B","C","D"]
    var practiceType_Array = ["- - -","jog","LSD","ペースラン","ビルドアップ","ショートインターバル","ロングインターバル","変化走","刺激","調整","筋トレ","その他"]
    
    var hourNumber_Array: [String]! = ["--"]
    var timeNumber_Array: [String]! = ["--"]
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
        
        
        //PV in TF
        let dict = [team_PV:team_TF,practiceType_PV:practiceType_TF,upTime_PV:upTime_TF,downTime_PV:downTime_TF]
        var count = 0
        for (pv, tf) in dict {
            pv.delegate = self
            pv.dataSource = self
            tf?.inputView = pv
            tf?.inputAccessoryView = toolbar
            pv.tag = count + 1
            tf?.tintColor = UIColor.clear
        }
        
        //TF
        let tfArray2 = [practice_comment_record,up_distance_record,down_distance_record]
        var count2 = -1
        for (tf) in tfArray2 {
            
            tf?.delegate = self
            tf?.tag = count2 + 1
            tf?.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        up_distance_record.keyboardType = .numberPad
        down_distance_record.keyboardType = .numberPad
        
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
        
        
        //SC
        practiceKind_SC.selectedSegmentTintColor = Asset.mainColor.color //選択しているボタンの背景色
        practiceKind_SC.backgroundColor = Asset.whiteColor.color //選択していないボタンの背景色
        
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected) //選択しているボタンのtextColor
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:Asset.mainColor.color], for: .normal)//選択していないボタンのtextColor
        
        
        
        //TV
        main_mene_record.delegate = self
        main_mene_record.dataSource = self
        
        //ScrollViewHeight
        scrollView_Const.constant = 831
        
        main_mene_record.rowHeight = 74
        
        // Do any additional setup after loading the view.
        
        
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        total_distance_record.isEnabled = false
        
        
        //userdefaultに保存されている日付をとってくる
        //今日の日付と一致しているかどうか確認
        //一致しない場合は
        //-->default値を設定
        
        let checkDay: String = UserDefaults.standard.string(forKey: "checkDay1")!
        let checkDay2: String = UserDefaults.standard.string(forKey: "checkDay2") ?? ""
        
        if checkDay == checkDay2 {
            
            team_Dictionary  = UserDefaults.standard.dictionary(forKey: "team")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            team_TF.text = team_Dictionary[selectedSC]
            
            practiceType_Dictionary  = UserDefaults.standard.dictionary(forKey: "practiceType")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            practiceType_TF.text = practiceType_Dictionary[selectedSC]
            
            practiceContent_Dictionary  = UserDefaults.standard.dictionary(forKey: "menu")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            practice_comment_record.text = practiceContent_Dictionary[selectedSC]
            
            upDistance_Dictionary  = UserDefaults.standard.dictionary(forKey: "upDistance")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            up_distance_record.text = upDistance_Dictionary[selectedSC]
            
            downDistance_Dictionary  = UserDefaults.standard.dictionary(forKey: "downDistance")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            down_distance_record.text = downDistance_Dictionary[selectedSC]
            
            totalDistance_String  = UserDefaults.standard.string(forKey: "totalDistance") ?? "0"
            total_distance_record.text = totalDistance_String
            
            upTime_Dictionary  = UserDefaults.standard.dictionary(forKey: "upTime")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            upTime_TF.text = upTime_Dictionary[selectedSC]
            
            downTime_Dictionary  = UserDefaults.standard.dictionary(forKey: "downTime")as? [String:String] ?? ["main": "", "sub":"", "free":""]
            downTime_TF.text = downTime_Dictionary[selectedSC]
            
            runAllData  = UserDefaults.standard.dictionary(forKey: "runDetail")as? [String:[String:[String:Any]]] ?? ["main": ["0":["distance": "","time": "","pace": ""]],"sub": ["0":["distance": "","time": "","pace": ""]],"free": ["0":["distance": "","time": "","pace": ""]]]
            main_mene_record.reloadData()
            
        }
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
            
            
            //totalDistance_反映_始
            
            let SCKind_Array = ["main","sub","free"]
            var SCKind_String = ""
            
            var lineCount = 0
            
            var totalDistance_Int = 0
            
            
            //メニュー詳細部分の距離合計
            for n in 0...2 {
                
                SCKind_String = SCKind_Array[n]
                
                lineCount = runAllData[SCKind_String]?.count ?? 0
                
                if lineCount == 0 {
                    
                    //配列0のため何も起こさない
                    
                } else {
                    
                    
                    for m in 0...lineCount - 1 {
                        
                        let electedDistance_String = runAllData[SCKind_String]?["\(m)"]?["distance"] ?? "0"
                        
                        let electedDistance_Int = Int(electedDistance_String as! String) ?? 0
                        
                        totalDistance_Int += electedDistance_Int
                        
                    }
                    
                    
                }
                
                
                //アップ部分の距離合計
                let electedUpDistance_String = upDistance_Dictionary[SCKind_String] ?? "0"
                let electedUpDistance_Int = Int(electedUpDistance_String) ?? 0
                
                totalDistance_Int += electedUpDistance_Int
                
                //ダウン部分の距離合計
                let electedDownDistance_String = downDistance_Dictionary[SCKind_String] ?? "0"
                let electedDownDistance_Int = Int(electedDownDistance_String) ?? 0
                
                totalDistance_Int += electedDownDistance_Int
                
                
                
            }
            
            
            
            
            total_distance_record.text = "\(totalDistance_Int)m"
            totalDistance_String = "\(totalDistance_Int)"
            //totalDistance_反映_終了
            
            
            
            
        } else if textField.tag == 2 {
            downDistance_Dictionary[selectedSC] = textField.text!
            print("downdistance: \(downDistance_Dictionary[selectedSC]!)")
            
            
            
            
            //totalDistance_反映_始
            
            let SCKind_Array = ["main","sub","free"]
            var SCKind_String = ""
            
            var lineCount = 0
            
            var totalDistance_Int = 0
            
            
            //メニュー詳細部分の距離合計
            for n in 0...2 {
                
                SCKind_String = SCKind_Array[n]
                
                lineCount = runAllData[SCKind_String]?.count ?? 0
                
                if lineCount == 0 {
                    
                    //配列0のため何も起こさない
                    
                } else {
                    
                    
                    for m in 0...lineCount - 1 {
                        
                        let electedDistance_String = runAllData[SCKind_String]?["\(m)"]?["distance"] ?? "0"
                        
                        let electedDistance_Int = Int(electedDistance_String as! String) ?? 0
                        
                        totalDistance_Int += electedDistance_Int
                        
                    }
                    
                    
                }
                
                
                //アップ部分の距離合計
                let electedUpDistance_String = upDistance_Dictionary[SCKind_String] ?? "0"
                let electedUpDistance_Int = Int(electedUpDistance_String) ?? 0
                
                totalDistance_Int += electedUpDistance_Int
                
                //ダウン部分の距離合計
                let electedDownDistance_String = downDistance_Dictionary[SCKind_String] ?? "0"
                let electedDownDistance_Int = Int(electedDownDistance_String) ?? 0
                
                totalDistance_Int += electedDownDistance_Int
                
                
                
            }
            
            
            
            
            total_distance_record.text = "\(totalDistance_Int)m"
            totalDistance_String = "\(totalDistance_Int)"
            //totalDistance_反映_終了
            
            
            
            
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
            
            
            
            //ペースorタイム自動反映
            
            
            if oneRunDetail["time"] == "" && oneRunDetail["pace"] == "" {
                //タイムとペースの値なしのため
                //ペースorタイム自動反映は保留
                
            } else if oneRunDetail["pace"] == "" {
                
                //ペース自動反映開始
                
                let minuteS = oneRunDetail["time"]!.prefix(2)
                let secondS = oneRunDetail["time"]!.suffix(2)
                
                let minuteA = Int(minuteS)!
                let secondA = Int(secondS)!
                
                let distanceA = Int(oneRunDetail["distance"] ?? "0") ?? 0
                
                let timeA = minuteA*60 + secondA  //入力されたタイムの秒数値
                
                let timeB = timeA * 1000 / distanceA //1000mあたりのタイムの秒数値
                
                let minuteB: Int = timeB / 60  //1000mあたりのタイムの分
                let secondB: Int = timeB % 60  //1000mあたりのタイムの秒
                
                var minuteC: String = ""
                var secondC: String = ""
                
                if minuteB < 10 {
                    
                    minuteC = "0\(minuteB)"
                    
                } else {
                    
                    minuteC = "\(minuteB)"
                    
                }
                
                
                if secondB < 10 {
                    
                    secondC = "0\(secondB)"
                    
                } else {
                    
                    secondC = "\(secondB)"
                    
                }
                
                
                
                oneRunDetail.updateValue("\(minuteC):\(secondC)", forKey: "pace")
                
                //MARK: NEW - ペース
                //                let paceTF = self.view.viewWithTag(textField.tag - 100 + 300) as! UITextField
                let paceTF = self.view.viewWithTag(textField.tag + 200) as! UITextField
                paceTF.text = "\(minuteC):\(secondC)/km"
                
                //picker初期値設定
                //                let pacePV = self.view.viewWithTag(textField.tag - 100 + 500) as! UIPickerView
                //                let pacePV = self.view.viewWithTag(textField.tag + 400) as! UIPickerView
                //
                //                pacePV.selectRow(minuteB, inComponent: 0, animated: false)
                //                pacePV.selectRow(secondB, inComponent: 2, animated: false)
                
                //ペース自動反映終了
                
            } else {
                
                //タイム自動反映開始
                
                
                let minuteS = oneRunDetail["pace"]!.prefix(2)
                let secondS = oneRunDetail["pace"]!.suffix(2)
                
                print("minuteS",minuteS)
                
                let minuteA = Int(minuteS)!
                let secondA = Int(secondS)!
                
                let distanceA = Int(oneRunDetail["distance"] ?? "0") ?? 0
                
                let timeA = minuteA*60 + secondA  //入力されたペースの秒数値
                
                let timeB: Double = Double(timeA * distanceA / 1000) //1000mあたりのタイムの秒数値
                
                let minuteB: Int = Int(timeB / 60)  //1000mあたりのタイムの分
                let secondB: Int = Int(timeB) % 60 //1000mあたりのタイムの秒
                
                var minuteC: String = ""
                var secondC: String = ""
                
                if minuteB < 10 {
                    
                    minuteC = "0\(minuteB)"
                    
                } else {
                    
                    minuteC = "\(minuteB)"
                    
                }
                
                
                if secondB < 10 {
                    
                    secondC = "0\(secondB)"
                    
                } else {
                    
                    secondC = "\(secondB)"
                    
                }
                
                
                
                oneRunDetail.updateValue("\(minuteC):\(secondC)", forKey: "time")
                
                //MARK: NEW - タイム
                //                let timeTF = self.view.viewWithTag(textField.tag - 100 + 200) as! UITextField
                let timeTF = self.view.viewWithTag(textField.tag + 100) as! UITextField
                timeTF.text = "\(minuteC):\(secondC)"
                
                
                //picker初期値設定
                //                let timePV = self.view.viewWithTag(textField.tag - 100 + 400) as! UIPickerView
                //                let timePV = self.view.viewWithTag(textField.tag + 300) as! UIPickerView
                //                timePV.selectRow(minuteB, inComponent: 0, animated: false)
                //                timePV.selectRow(secondB, inComponent: 2, animated: false)
                
                //タイム自動反映終了
                
                
                
                
                
            }
            
            
            //ペースorタイム自動反映
            
            //            ここを有効にすると正しく反映されるが、１文字打ったごとにキーボードが閉じてしまう
            //            main_mene_record.reloadData()
            
            
            
            
            
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(textField.tag - 100)")
            print("distance - changed",runAllData[selectedSC]!)
            
            
            
            //totalDistance_反映_始
            
            let SCKind_Array = ["main","sub","free"]
            var SCKind_String = ""
            
            var lineCount = 0
            
            var totalDistance_Int = 0
            
            
            //メニュー詳細部分の距離合計
            for n in 0...2 {
                
                SCKind_String = SCKind_Array[n]
                
                lineCount = runAllData[SCKind_String]?.count ?? 0
                
                if lineCount == 0 {
                    
                    //配列0のため何も起こさない
                    
                } else {
                    
                    
                    for m in 0...lineCount - 1 {
                        
                        let electedDistance_String = runAllData[SCKind_String]?["\(m)"]?["distance"] ?? "0"
                        
                        let electedDistance_Int = Int(electedDistance_String as! String) ?? 0
                        
                        totalDistance_Int += electedDistance_Int
                        
                    }
                    
                    
                }
                
                
                //アップ部分の距離合計
                let electedUpDistance_String = upDistance_Dictionary[SCKind_String] ?? "0"
                let electedUpDistance_Int = Int(electedUpDistance_String) ?? 0
                
                totalDistance_Int += electedUpDistance_Int
                
                //ダウン部分の距離合計
                let electedDownDistance_String = downDistance_Dictionary[SCKind_String] ?? "0"
                let electedDownDistance_Int = Int(electedDownDistance_String) ?? 0
                
                totalDistance_Int += electedDownDistance_Int
                
                
                
            }
            
            
            
            
            total_distance_record.text = "\(totalDistance_Int)m"
            totalDistance_String = "\(totalDistance_Int)"
            //totalDistance_反映_終了
            
            
            
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
            
            
            //MARK: NEW - タイム
            //            let timeTF = self.view.viewWithTag(pickerView.tag - 400 + 200) as! UITextField
            let timeTF = self.view.viewWithTag(pickerView.tag - 200) as! UITextField
            timeTF.text = "\(tvTimeMinute_Dictionary[selectedSC]!):\(tvTimeSecond_Dictionary[selectedSC]!)"
            
            //picker初期値設定
            //                let timePV = self.view.viewWithTag(textField.tag - 400 + 400) as! UIPickerView
            //            let timePV = self.view.viewWithTag(pickerView.tag) as! UIPickerView
            //
            //            let minuteB = Int(tvTimeMinute_Dictionary[selectedSC]!)!
            //            let secondB = Int(tvTimeSecond_Dictionary[selectedSC]!)!
            //
            //            timePV.selectRow(minuteB, inComponent: 0, animated: false)
            //            timePV.selectRow(secondB, inComponent: 2, animated: false)
            
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
            
            
            
            //ペース自動反映
            
            
            if oneRunDetail["distance"] == "" {
                //距離の値なしのため
                //ペース自動反映は保留
                
            } else {
                
                //ペース自動反映開始
                let minuteA = Int(tvTimeMinute_Dictionary[selectedSC]!) ?? 0
                let secondA = Int(tvTimeSecond_Dictionary[selectedSC]!) ?? 0
                
                let distanceA = Int(oneRunDetail["distance"] ?? "0") ?? 0
                let timeA = minuteA*60 + secondA  //入力されたタイムの秒数値
                var timeB = 0 //1000mあたりのタイムの秒数値
                var minuteB = 0  //1000mあたりのタイムの分
                var secondB = 0  //1000mあたりのタイムの秒
                
                if distanceA != 0 {
                    timeB = timeA * 1000 / distanceA //1000mあたりのタイムの秒数値
                    minuteB = timeB / 60  //1000mあたりのタイムの分
                    secondB = timeB % 60  //1000mあたりのタイムの秒
                }
                
                
                
                var minuteC: String = ""
                var secondC: String = ""
                
                if minuteB < 10 {
                    
                    minuteC = "0\(minuteB)"
                    
                } else {
                    
                    minuteC = "\(minuteB)"
                    
                }
                
                
                if secondB < 10 {
                    
                    secondC = "0\(secondB)"
                    
                } else {
                    
                    secondC = "\(secondB)"
                    
                }
                
                
                
                oneRunDetail.updateValue("\(minuteC):\(secondC)", forKey: "pace")
                
                
                //MARK: NEW - ペース
                //                let paceTF = self.view.viewWithTag(pickerView.tag - 400 + 300) as! UITextField
                let paceTF = self.view.viewWithTag(pickerView.tag - 100) as! UITextField
                paceTF.text = "\(minuteC):\(secondC)/km"
                
                
                //picker初期値設定
                //                let timePV = self.view.viewWithTag(pickerView.tag - 400 + 500) as! UIPickerView
                //                var tagA = pickerView.tag + 100
                //
                //                print("tagA",tagA)
                //
                //                let pacePV = self.view.viewWithTag(tagA) as! UIPickerView
                //
                //                pacePV.selectRow(minuteB, inComponent: 0, animated: false)
                //                pacePV.selectRow(secondB, inComponent: 2, animated: false)
                
                
            }
            
            
            //ペース自動反映
            
            
            
            
            
            
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(pickerView.tag - 400)")
            print("time - changed",runAllData[selectedSC]!)
            
            print("ここからですよ",runAllData)
            
            //            main_mene_record.reloadData()
            
            
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
            
            
            //MARK: NEW - ペース
            //            let paceTF = self.view.viewWithTag(pickerView.tag - 500 + 300) as! UITextField
            let paceTF = self.view.viewWithTag(pickerView.tag - 200) as! UITextField
            paceTF.text = "\(tvPaceMinute_Dictionary[selectedSC]!):\(tvPaceSecond_Dictionary[selectedSC]!)/km"
            
            
            
            //picker初期値設定
            //                let timePV = self.view.viewWithTag(textField.tag - 500 + 500) as! UIPickerView
            //            let pacePV = self.view.viewWithTag(pickerView.tag) as! UIPickerView
            //
            //            let minuteB = Int(tvPaceMinute_Dictionary[selectedSC]!)!
            //            let secondB = Int(tvPaceSecond_Dictionary[selectedSC]!)!
            //
            //            pacePV.selectRow(minuteB, inComponent: 0, animated: false)
            //            pacePV.selectRow(secondB, inComponent: 2, animated: false)
            //
            
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
            
            
            
            
            //タイム自動反映
            
            
            if oneRunDetail["distance"] == "" {
                //距離の値なしのため
                //タイム自動反映は保留
                
            } else {
                
                //タイム自動反映開始
                
                let minuteA = Int(tvPaceMinute_Dictionary[selectedSC]!) ?? 0
                let secondA = Int(tvPaceSecond_Dictionary[selectedSC]!) ?? 0
                
                let distanceA = Int(oneRunDetail["distance"] ?? "0") ?? 0
                
                let timeA = minuteA*60 + secondA  //入力されたペースの秒数値
                
                let timeB: Double = Double(timeA * distanceA / 1000) //1000mあたりのタイムの秒数値
                
                let minuteB: Int = Int(timeB / 60)  //1000mあたりのタイムの分
                let secondB: Int = Int(timeB) % 60 //1000mあたりのタイムの秒
                
                var minuteC: String = ""
                var secondC: String = ""
                
                if minuteB < 10 {
                    
                    minuteC = "0\(minuteB)"
                    
                } else {
                    
                    minuteC = "\(minuteB)"
                    
                }
                
                
                if secondB < 10 {
                    
                    secondC = "0\(secondB)"
                    
                } else {
                    
                    secondC = "\(secondB)"
                    
                }
                
                
                
                oneRunDetail.updateValue("\(minuteC):\(secondC)", forKey: "time")
                
                //MARK: NEW - タイム
                //                let timeTF = self.view.viewWithTag(pickerView.tag - 500 + 200) as! UITextField
                let timeTF = self.view.viewWithTag(pickerView.tag - 300) as! UITextField
                timeTF.text = "\(minuteC):\(secondC)"
                
                //picker初期値設定
                //                let timePV = self.view.viewWithTag(textField.tag - 500 + 400) as! UIPickerView
                //                let timePV = self.view.viewWithTag(pickerView.tag - 100) as! UIPickerView
                //
                //                timePV.selectRow(minuteB, inComponent: 0, animated: false)
                //                timePV.selectRow(secondB, inComponent: 2, animated: false)
                
                
            }
            
            
            //タイム自動反映
            
            
            
            runAllData[selectedSC]!.updateValue(oneRunDetail, forKey: "\(pickerView.tag - 500)")
            print("pace - changed",runAllData[selectedSC]!)
            
            
            print("ここからですよ",runAllData)
            
            //            main_mene_record.reloadData()
            
        }
        //~TV
        
        
    }
    
    
    @objc func done() {
        self.view.endEditing(true)
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
        
        runningData_Dictionary1 = runAllData[selectedSC]!
        //ScrollViewHeight
        scrollView_Const.constant = CGFloat(757 + 74 * self.runningData_Dictionary1.count)
        
        return self.runningData_Dictionary1.count
        
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Record_1_TableViewCell
        
        cell.distance_TF?.delegate = self
        
        cell.distance_TF?.tag = 100 + indexPath.row
        cell.time_TF?.tag = 200 + indexPath.row
        cell.pace_TF?.tag = 300 + indexPath.row
        
        //keyBoardType設定
        cell.distance_TF?.keyboardType = .numberPad
        
        cell.distance_TF?.addTarget(self, action: #selector(Record_1_ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        runningData_Dictionary1 = runAllData[selectedSC]!
        runningData_Dictionary2 = runningData_Dictionary1 as! [String:[String:Any]]
        
        cell.distance_TF?.text = runningData_Dictionary2["\(indexPath.row)"]?["distance"] as? String ?? ""
        cell.time_TF?.text = runningData_Dictionary2["\(indexPath.row)"]?["time"] as? String ?? ""
        
        let pace_TF_Text = runningData_Dictionary2["\(indexPath.row)"]?["pace"] as? String ?? ""
        
        if pace_TF_Text == "" {
            cell.pace_TF?.text = ""
        } else {
            cell.pace_TF?.text = "\(pace_TF_Text)/km"
        }
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //number_Labelのtext設定
        let numberTemprate = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩"]
        if indexPath.row < 10 {
            cell.number_Label?.text = numberTemprate[indexPath.row]
        } else {
            cell.number_Label?.text = "\(indexPath.row + 1)."
        }
        
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
        
        cell.pace_TF?.tintColor = UIColor.clear
        
        //totalDistance_反映_始
        let SCKind_Array = ["main","sub","free"]
        var SCKind_String = ""
        
        var lineCount = 0
        var totalDistance_Int = 0
        
        //メニュー詳細部分の距離合計
        for n in 0...2 {
            SCKind_String = SCKind_Array[n]
            lineCount = runAllData[SCKind_String]?.count ?? 0
            
            if lineCount != 0 {
                for m in 0...lineCount - 1 {
                    let electedDistance_String = runAllData[SCKind_String]?["\(m)"]?["distance"] ?? "0"
                    let electedDistance_Int = Int(electedDistance_String as! String) ?? 0
                    totalDistance_Int += electedDistance_Int
                }
            }
            
            //アップ部分の距離合計
            let electedUpDistance_String = upDistance_Dictionary[SCKind_String] ?? "0"
            let electedUpDistance_Int = Int(electedUpDistance_String) ?? 0
            
            totalDistance_Int += electedUpDistance_Int
            
            //ダウン部分の距離合計
            let electedDownDistance_String = downDistance_Dictionary[SCKind_String] ?? "0"
            let electedDownDistance_Int = Int(electedDownDistance_String) ?? 0
            
            totalDistance_Int += electedDownDistance_Int
            
        }
        
        
        total_distance_record.text = "\(totalDistance_Int)m"
        totalDistance_String = "\(totalDistance_Int)"
        //totalDistance_反映_終了
        
        
        //MARK: *重要* picker初期値設定
        //        let pacePV = self.view.viewWithTag(indexPath.row + 500) as! UIPickerView
        //
        //        var minuteD =
        //        var secondD =
        //
        //        pacePV.selectRow(minuteD, inComponent: 0, animated: false)
        //        pacePV.selectRow(secondD, inComponent: 2, animated: false)
        
        return cell  //cellの戻り値を設定
    }
    
    
    
    
    @IBAction func tap1(_ sender: UIButton) {
        team_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel1(_ sender: UIButton) {
        team_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func teamtype_record() {
        team_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func tap2(_ sender: UIButton) {
        practiceType_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel2(_ sender: UIButton) {
        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func practictype_record() {
        practiceType_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func tap3(_ sender: UIButton) {
        up_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel3(_ sender: UIButton) {
        up_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func up_time_record() {
        up_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func runDetail_Add() {
        
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
        main_mene_record.reloadData()
        
    }
    
    @IBAction func tap4(_ sender: UIButton) {
        down_picture.image = UIImage(named: "w_pushed_long")
    }
    
    @IBAction func cancel4(_ sender: UIButton) {
        down_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    @IBAction func down_time_record() {
        down_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    
    
    //朝練・本練・自主練 選択時
    @IBAction func practiceKind_Selected(_ sender: UISegmentedControl) {
        
        var kindArray = ["sub","main","free"]
        selectedSC = kindArray[sender.selectedSegmentIndex]
        
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
    
    
    
    @IBAction func tap6(_ sender: UIButton) {
        complete_picture.image = UIImage(named: "p_pushed_s")
    }
    
    @IBAction func cancel6(_ sender: UIButton) {
        complete_picture.image = UIImage(named: "p_nonpushed_s")
    }
    
    @IBAction func complete() {
        complete_picture.image = UIImage(named: "p_nonpushed_s")
        var check_Dictionary = ["main":"YES","sub":"YES","free":"YES"]
        var check_String = "NONE"
        let SCKind_Array = ["main","sub","free"]
        var SCKind_String = ""
        var SCKindJP_String = ""
        var checksecond = "YES"
        var errorType_String = ""
        
        for n in 0...2 {
            
            SCKind_String = SCKind_Array[n]
            
            if team_Dictionary[SCKind_String] == "" && practiceType_Dictionary[SCKind_String] == "" && practiceContent_Dictionary[SCKind_String] == "" /*&& upDistance_Dictionary[SCKind_String] == "" && downDistance_Dictionary[SCKind_String] == "" && totalDistance_String == "" && upTime_Dictionary[SCKind_String] == "" && downTime_Dictionary[SCKind_String] == ""*/ {
                //MARK: TOTALDISTANCE 要注意・編集
                //すべて入力されていない
                //この場合このSCは飛ばし
                
            } else {
                
                func SCKindJP() {
                    check_Dictionary[SCKind_String] = "NO"
                    var SCKind_Dict = ["main":"本練習","sub":"朝練","free":"自主練習"]
                    SCKindJP_String = SCKind_Dict[SCKind_String] ?? "不明"
                }
                
                if team_Dictionary[SCKind_String] == "" || team_Dictionary[SCKind_String] == "- - -" {
                    errorType_String = "チームの"
                    SCKindJP()
                    
                } else if practiceType_Dictionary[SCKind_String] == "" || practiceType_Dictionary[SCKind_String] == "- - -" {
                    errorType_String = "練習タイプの"
                    SCKindJP()
                    
                } else if practiceContent_Dictionary[SCKind_String] == "" {
                    errorType_String = "内容の"
                    SCKindJP()
                    
                }/* else if upDistance_Dictionary[SCKind_String] == "" {
                  errorType_String = "アップの距離の"
                  check_Dictionary[SCKind_String] = "NO"
                  SCKindJP()
                  
                  } else if downDistance_Dictionary[SCKind_String] == "" {
                  errorType_String = "ダウンの距離の"
                  check_Dictionary[SCKind_String] = "NO"
                  SCKindJP()
                  
                  }*//* else if totalDistance_String == "" {
                      errorType_String = "トータル距離"
                      
                      }*//* else if upTime_Dictionary[SCKind_String] == "" {
                          errorType_String = "アップのタイムの"
                          check_Dictionary[SCKind_String] = "NO"
                          SCKindJP()
                          
                          } else if downTime_Dictionary[SCKind_String] == "" {
                          errorType_String = "ダウンのタイムの"
                          check_Dictionary[SCKind_String] = "NO"
                          SCKindJP()
                          
                          }*/ else if runAllData[SCKind_String] == nil {
                              //メニュー詳細入力一切なし
                              errorType_String = "メニュー詳細の"
                              SCKindJP()
                              
                          } else {
                              
                              var runDetailNillcheck = "OK"
                              
                              var count = runAllData[selectedSC]!.count
                              if count == 0 {
                                  count = 1
                              }
                              
                              for n in 0...count - 1 {
                                  let runAdata = runAllData[selectedSC]?["\(n)"] ?? ["distance": "","time":"","pace":""]
                                  
                                  if runDetailNillcheck == "OK" {
                                      
                                      let distance = runAdata["distance"]
                                      let time = runAdata["time"]
                                      let pace = runAdata["pace"]
                                      
                                      let runAdataKey = ["distance","time","pace"]
                                      for (value) in runAdataKey {
                                          if value == "" || value == "--:--" {
                                              runDetailNillcheck = "NO"
                                          }
                                      }
                                  }
                              }
                              
                              
                              if runDetailNillcheck == "OK" {
                                  //完了
                                  //いずれかひとつのSC完全入力済
                                  check_Dictionary[SCKind_String] = "YES"
                                  
                              } else {
                                  //エラー
                                  errorType_String = "メニュー詳細の"
                                  SCKindJP()
                                  
                              }
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
        
        
        func udSet(remove:Bool) {
            let keyDict = ["team","practiceType","menu","upDistance","downDistance","upTime","downTime",
                           "totalDistance","runDetail"]
            let valueDict = [team_Dictionary,practiceType_Dictionary,practiceContent_Dictionary,upDistance_Dictionary,downDistance_Dictionary,upTime_Dictionary,downTime_Dictionary,totalDistance_String,runAllData] as [Any]
            
            for n in 0...keyDict.count-1 {
                let udkey = keyDict[n]
                if remove {
                    UserDefaults.standard.removeObject(forKey: udkey)
                } else {
                    UserDefaults.standard.set(valueDict[n], forKey: udkey)
                }
            }
        }
        
        
        if check_String == "YES" {
            
            //いずれかひとつのSCが全て入力済
            udSet(remove: false)
            print(runAllData)
            
            //完了
            let loadDate_Formatter = DateFormatter()  //DP
            let today = Date()
            loadDate_Formatter.dateFormat = "yyyy"
            var todayYear = loadDate_Formatter.string(from: today)
            loadDate_Formatter.dateFormat = "M"
            var todayMonth = loadDate_Formatter.string(from: today)
            loadDate_Formatter.dateFormat = "d"
            var todayDay = loadDate_Formatter.string(from: today)
            
            UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)" ,forKey: "checkDay2")
            self.navigationController?.popViewController(animated: true)
            
            
        } else if check_String == "NO" {
            
            //エラー版
            AlertHost.alertDoubleDef(view: self, alertTitle: "\(SCKindJP_String)の\(errorType_String)記録に\n記入漏れがあるようです", alertMessage: "保存するには、\n朝練・本練・自主練習のいずれかを\n完全に入力する必要があります。\nメニューの記録をやめて\nトップ画面に戻りますか？", b1Title: "メニューの記録をやめる", b1Style: .default, b2Title: "入力し直す") { _ in
                //メニューの記録データを全て ""(値なし) にして前ページへ
                udSet(remove: true)
                self.navigationController?.popViewController(animated: true)
            }
            
        } else if check_String == "NONE" {
            
            //エラー版
            AlertHost.alertDoubleDef(view: self, alertTitle: "すべての情報が\n入力されていません", alertMessage: "保存するには、\n朝練・本練・自主練習のいずれかを\n完全に入力する必要があります。\nメニューの記録をやめて\nトップ画面に戻りますか？", b1Title: "メニューの記録をやめる", b1Style: .default, b2Title: "入力し直す") { _ in
                //メニューの記録データを全て ""(値なし) にして前ページへ
                udSet(remove: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
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
