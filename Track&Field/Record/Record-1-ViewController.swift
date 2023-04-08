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
    var runDetailDatas: [RunDetailTemplate?]? = []
    var oneRunDetail: RunDetailTemplate?
    
    //どのSegumentedControllが選ばれているか
    var selectedSC: String! = "main"
    
    var mainData: DetailDataTemp? = DetailDataTemp()
    var subData: DetailDataTemp? = DetailDataTemp()
    var freeData: DetailDataTemp? = DetailDataTemp()
    
    var electedData: DetailDataTemp?
    
    var team_Array: Array! = ["- - -","A","B","C","D"]
    var practiceType_Array: Array! = ["- - -","jog","LSD","ペースラン","ビルドアップ","ショートインターバル","ロングインターバル","変化走","刺激","調整","筋トレ","その他"]
    
    var hourNumber_Array: Array! = ["--"]
    var timeNumber_Array: Array! = ["--"]
    var timeUnit_Array: Array! = [":"]
    var error_Array: Array! = ["エラー"]
    
    
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
        let pvArray = [team_PV,practiceType_PV,upTime_PV,downTime_PV]
        let tfArray = [team_TF,practiceType_TF,upTime_TF,downTime_TF]
        for n in 0...pvArray.count-1 {
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
        let tfArray2 = [practice_comment_record,up_distance_record,down_distance_record]
        for n in 0...tfArray2.count-1 {
            let tf = tfArray2[n]
            tf?.delegate = self
            tf?.tag = n
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
        
        let checkDay: String = UserDefaults.standard.string(forKey: "checkDay1") ?? "none - checkDay1"
        let checkDay2: String = UserDefaults.standard.string(forKey: "checkDay2") ?? "none - checkDay2"
        
        if checkDay == checkDay2 {
            
            mainData = UserDefaults.standard.object(forKey: "mainData") as? DetailDataTemp ?? DetailDataTemp()
            subData = UserDefaults.standard.object(forKey: "subData") as? DetailDataTemp ?? DetailDataTemp()
            freeData = UserDefaults.standard.object(forKey: "freeData") as? DetailDataTemp ?? DetailDataTemp()
            setUI()
            
        } else {
            setDetailData(remove: true)
            mainData = DetailDataTemp()
            subData = DetailDataTemp()
            freeData = DetailDataTemp()
            setUI()
        }
    }
    
    func setUI() {
        let kindArray = ["sub": subData, "main": mainData, "free": freeData]
        electedData = kindArray[selectedSC] as? DetailDataTemp
        
        print("electedData: ", electedData ?? "none - DetailData")
        print("SETUI(selectedSC: \(selectedSC ?? "unknown")")
        
        team_TF.text = electedData?.team ?? ""
        practiceType_TF.text = electedData?.practiceType ?? ""
        upTime_TF.text = "\(electedData?.upTime.hour ?? ""):\(electedData?.upTime.minute ?? ""):\(electedData?.upTime.second ?? "")"
        downTime_TF.text = "\(electedData?.downTime.hour ?? ""):\(electedData?.downTime.minute ?? ""):\(electedData?.downTime.second ?? "")"
        
        practice_comment_record.text = electedData?.menu ?? ""
        up_distance_record.text = electedData?.upDistance ?? ""
        down_distance_record.text = electedData?.downDistance ?? ""
        
        main_mene_record.reloadData()
    }
    
    
    //MARK: セルの各値の表示設定
    func setCellTFValue(tag: Int) {
        let distanceTF = self.view.viewWithTag(tag + 100) as! UITextField
        distanceTF.text = "\(oneRunDetail?.distance ?? "0")"
        
        let timeTF = self.view.viewWithTag(tag + 200) as! UITextField
        timeTF.text = "\(oneRunDetail?.time.minute ?? "00"):\(oneRunDetail?.time.second ?? "00")"
        
        let paceTF = self.view.viewWithTag(tag + 300) as! UITextField
        paceTF.text = "\(oneRunDetail?.pace.minute ?? "00"):\(oneRunDetail?.pace.second ?? "00")/km"
        
    }
    
    func setDetailData(remove:Bool) {
        if remove {
            UserDefaults.standard.removeObject(forKey: "mainData")
            UserDefaults.standard.removeObject(forKey: "subData")
            UserDefaults.standard.removeObject(forKey: "freeData")
            
        } else {
            
            let detailDataDict = ["main": mainData, "sub": subData, "free": freeData]
            guard let detailDatas = try? NSKeyedArchiver.archivedData(withRootObject: detailDataDict, requiringSecureCoding: false)
            else { return }
            
            UserDefaults.standard.set(detailDatas, forKey: "detailDatas")
            
        }
    }
    
    
    //TF
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //キーボードを閉じる
        return true //戻り値
    }
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        print("TextField: \(textField.text!)")
        
        if textField.tag == 0 {
            electedData?.menu = textField.text!
            print("practicecomment: \(electedData?.menu ?? "none")")
            
        } else if textField.tag == 1 {
            electedData?.upDistance = textField.text!
            print("updistance: \(electedData?.upDistance ?? "none")")
            
            //totalDistance_反映_始
            //totalDistance_反映_終了
            
            
        } else if textField.tag == 2 {
            electedData?.downDistance = textField.text!
            print("downdistance: \(electedData?.downDistance ?? "none")")
            
            //totalDistance_反映_始
            //totalDistance_反映_終了
            
            
        }
        
        //tableView - runDetail
        else if textField.tag >= 100 && textField.tag < 200 {
            
            //MARK: NEWCELL設定
            let tag = textField.tag % 100
            oneRunDetail = electedData?.runDetail?[tag]
            //距離
            oneRunDetail?.distance = textField.text!
            print("row: \(tag)\ndistance: \(oneRunDetail?.distance ?? "none")")
            
            oneRunDetail?.calculatePace() //ペース,タイム計算 from - Dis
            setCellTFValue(tag: tag)
            
            //totalDistance_反映_始
            //totalDistance_反映_終了
            
            
        }
    }
    
    
    //PV
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 3 || pickerView.tag == 4 {
            return 5
            
        } else if pickerView.tag >= 400 && pickerView.tag < 600 {
            //400台: time // 500台: pace
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
            
        } else if pickerView.tag == 3 || pickerView.tag == 4 {
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
            
        } else if pickerView.tag >= 400 && pickerView.tag < 600 {
            //400台: time // 500台: pace
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
            
        } else if pickerView.tag == 3 || pickerView.tag == 4 {
            
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
            
        } else if pickerView.tag >= 400 && pickerView.tag < 600 {
            //400台: time // 500台: pace
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
            
        } else {
            return error_Array[row]
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let tag = pickerView.tag % 100
        if row == 0 {
            //"- - -"の際は何もしない
        } else {
            // 処理
            if pickerView.tag == 1 {
                electedData?.team = team_Array[row]
                team_TF.text = electedData?.team
                print("team: \(electedData?.team ?? "")")
                
            } else if pickerView.tag == 2 {
                electedData?.practiceType = practiceType_Array[row]
                practiceType_TF.text = electedData?.practiceType
                print("practiceType: \(electedData?.practiceType ?? "")")
                
            } else if pickerView.tag == 3 {
                
                switch component {
                case 0:
                    electedData?.upTime.hour = hourNumber_Array[row]
                case 2:
                    electedData?.upTime.minute = timeNumber_Array[row]
                case 4:
                    electedData?.upTime.second = timeNumber_Array[row]
                    
                default:
                    break
                }
                
                upTime_TF.text = "\(electedData?.upTime.hour ?? "00"):\(electedData?.upTime.minute ?? "00"):\(electedData?.upTime.second ?? "00")"
                print("upTime: \(upTime_TF.text ?? "")")
                
            } else if pickerView.tag == 4 {
                
                switch component {
                case 0:
                    electedData?.downTime.hour = hourNumber_Array[row]
                case 2:
                    electedData?.downTime.minute = timeNumber_Array[row]
                case 4:
                    electedData?.downTime.second = timeNumber_Array[row]
                default:
                    break
                }
                
                downTime_TF.text = "\(electedData?.downTime.hour ?? "00"):\(electedData?.downTime.minute ?? "00"):\(electedData?.downTime.second ?? "00")"
                print("downTime: \(downTime_TF.text ?? "")")
            }
            
            //TV~
            
            else if pickerView.tag >= 400 && pickerView.tag < 500 {
                
                oneRunDetail = electedData?.runDetail?[tag]
                switch component {
                case 0:
                    oneRunDetail?.time.minute = timeNumber_Array[row]
                case 2:
                    oneRunDetail?.time.second = timeNumber_Array[row]
                default:
                    break
                }
                
                //距離
                print("row: \(tag)\ntime: \(oneRunDetail?.time.minute ?? "timeMinuteError"):\(oneRunDetail?.time.second ?? "timeSecondError")")
                
                oneRunDetail?.calculatePace() //ペース,タイム計算 from - Pace
                setCellTFValue(tag: tag)
                
                //picker初期値設定
                //                let timePV = self.view.viewWithTag(textField.tag - 400 + 400) as! UIPickerView
                //            let timePV = self.view.viewWithTag(pickerView.tag) as! UIPickerView
                //
                //            let minuteB = Int(tvTimeMinute_Dictionary[selectedSC]!)!
                //            let secondB = Int(tvTimeSecond_Dictionary[selectedSC]!)!
                //
                //            timePV.selectRow(minuteB, inComponent: 0, animated: false)
                //            timePV.selectRow(secondB, inComponent: 2, animated: false)
                
                
            } else if pickerView.tag >= 500 && pickerView.tag < 600 {
                
                oneRunDetail = electedData?.runDetail?[tag]
                switch component {
                case 0:
                    oneRunDetail?.pace.minute = timeNumber_Array[row]
                case 2:
                    oneRunDetail?.pace.second = timeNumber_Array[row]
                default:
                    break
                }
                
                //ペース
                print("row: \(tag)\ntime: \(oneRunDetail?.pace.minute ?? "paceMinuteError"):\(oneRunDetail?.time.second ?? "paceSecondError")")
                
                oneRunDetail?.calculateTime() //ペース,タイム計算 from - Pace
                setCellTFValue(tag: tag)
                
                //picker初期値設定
                //                let timePV = self.view.viewWithTag(textField.tag - 500 + 400) as! UIPickerView
                //                let timePV = self.view.viewWithTag(pickerView.tag - 100) as! UIPickerView
                //
                //                timePV.selectRow(minuteB, inComponent: 0, animated: false)
                //                timePV.selectRow(secondB, inComponent: 2, animated: false)
                
                
            }
            //~TV
        }
        
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
        
        //ScrollViewHeight
        scrollView_Const.constant = CGFloat(757 + 74 * (electedData?.runDetail?.count ?? 0))
        return electedData?.runDetail?.count ?? 0
        
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
        print("行数: \(indexPath.row)")
        
        oneRunDetail = electedData?.runDetail?[indexPath.row]
        cell.distance_TF?.text = oneRunDetail?.distance
        cell.time_TF?.text = "\(oneRunDetail?.time.minute ?? "00"):\(oneRunDetail?.time.second ?? "00")"
        cell.pace_TF?.text = "\(oneRunDetail?.pace.minute ?? "00"):\(oneRunDetail?.pace.second ?? "00")/km"
        
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
        
        oneRunDetail = electedData?.runDetail?[(electedData?.runDetail?.count ?? 1) - 1]
        
        let addTime = oneRunDetail?.time
        let addPace = oneRunDetail?.pace
        
        let addRunDetail = RunDetailTemplate(distance: oneRunDetail?.distance, time: TimeTemplate.init(minute: addTime?.minute, second: addTime?.second), pace: TimeTemplate.init(minute: addPace?.minute, second: addPace?.second))
        
        electedData?.runDetail?.append(addRunDetail)
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
        
        let kindArray = ["sub","main","free"]
        selectedSC = kindArray[sender.selectedSegmentIndex]
        setUI()
        
    }
    
    
    
    @IBAction func tap6(_ sender: UIButton) {
        complete_picture.image = Asset.pPushedS.image
    }
    
    @IBAction func cancel6(_ sender: UIButton) {
        complete_picture.image = Asset.pNonpushedS.image
    }
    
    @IBAction func complete() {
        
        var dict: [String?: String?] = ["本練習": nil, "朝練習": nil, "自主練習": nil]
        let dict2: [String?: DetailDataTemp?] = ["本練習": mainData, "朝練習": subData, "自主練習": freeData]
        var nilCheckVar :String? = "none"
        var errorDataName: String?
        
        for (key, _) in dict {
            let data = dict2[key!] as? DetailDataTemp
            dict[key] = data?.nilCheck()
        }
        
        //何もなし："none"
        //入力済み：nil
        //未入力有："メニューの内容"
        
        for (key, value) in dict {
            if nilCheckVar == "none" || (value != nil && value != "none") {
                nilCheckVar = value
                errorDataName = key
            }
            //MARK: それ以外の場合はそのままで良い
        }
        
        
        if nilCheckVar == nil {
            //問題なし・保存して戻る
            setDetailData(remove: false)
            UserDefaults.standard.set(true, forKey: "menuCheck")
            self.navigationController?.popViewController(animated: true)
            
        } else if nilCheckVar == "none" {
            //全未入力のためバック
            setDetailData(remove: true)
            UserDefaults.standard.set(false, forKey: "menuCheck")
            self.navigationController?.popViewController(animated: true)
            
        } else {
            //未入力箇所あり
            let alertTitle = "\(errorDataName!)の\(nilCheckVar!)記録に\n記入漏れがあるようです"
            let alertMessage = "保存するには、\n朝練・本練・自主練習のいずれかを\n完全に入力する必要があります。\nメニューの記録をやめて\nトップ画面に戻りますか？"
            
            AlertHost.alertDoubleDef(view: self, alertTitle: alertTitle, alertMessage: alertMessage, b1Title: "メニューの記録をやめる", b1Style: .default, b2Title: "入力し直す") { [self] _ in
                self.setDetailData(remove: true)
                UserDefaults.standard.set(false, forKey: "menuCheck")
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
