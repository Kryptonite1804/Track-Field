//
//  History-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import SafariServices

class History_1_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var month_Label: UILabel!
    @IBOutlet weak var day_Label: UILabel!
    @IBOutlet weak var date_Label: UILabel!
    @IBOutlet weak var weather1_IV: UIImageView!
    @IBOutlet weak var weather2_IV: UIImageView!
    @IBOutlet weak var maxtemper_Label: UILabel!
    @IBOutlet weak var mintemper_Label: UILabel!
    @IBOutlet weak var today_practicetype_Label: UILabel!
    @IBOutlet weak var today_menu_Label: UILabel!
    @IBOutlet weak var today_up_distance_Label: UILabel!
    @IBOutlet weak var today_up_time_Label: UILabel!
    @IBOutlet weak var today_down_distance_Label: UILabel!
    @IBOutlet weak var today_down_time_Label: UILabel!
    @IBOutlet weak var today_total_distance_Label: UILabel!
    
    @IBOutlet weak var userGroup: UILabel!
    
    @IBOutlet weak var otherinfo_picture: UIImageView!
    
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var parcticemene_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    @IBOutlet weak var dateSlash_picture: UIImageView!
    
    @IBOutlet weak var practiceKind_SC: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView_Const: NSLayoutConstraint!
    //    @IBOutlet weak var tableView_Const: NSLayoutConstraint!
    
    @IBOutlet weak var noData_Label: UILabel!
    
    @IBOutlet weak var share_Button: UIButton!
    @IBOutlet weak var share_picture: UIImageView!
    //どのSegumentedControllが選ばれているか
    var selectedSC = "main"
    
    var totalDistance = ""
    var yobi = ""
    var month1: String!
    var month2: Int!
    var day1: String!
    var day2: Int!
    
    //menuBody全体を取得
    var getTodaymenuBody: [String:Any]!
    //Firebase_Dictionary で取得・表示
    var practicetype_Dictionary: [String:Any]!
    var menu_Dictionary: [String:Any]!
    var upDistance_Dictionary: [String:Any]!
    var upTime_Dictionary: [String:Any]!
    var downDistance_Dictionary: [String:Any]!
    var downTime_Dictionary: [String:Any]!
    
    
    var selectedRunningData: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let pastView = [practiceType_picture,parcticemene_picture,up_picture,down_picture,total_picture]
        //        for n in 0...pastView.count - 1 {
        //            let pastViewNum = pastView[n]
        //            pastViewNum?.layer.cornerRadius = 5
        //            pastViewNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        //            pastViewNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
        //            pastViewNum?.layer.shadowOpacity = 0.25  //影の濃さ
        //            pastViewNum?.layer.shadowRadius = 4.0 // 影のぼかし量
        //            pastViewNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        //            pastViewNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        //            pastViewNum?.layer.borderWidth = 1.0 // 枠線の太さ
        //        }
        
        //    let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
        
        //userdefault で取得・表示
        
        let which: String = UserDefaults.standard.string(forKey: "which") ?? ""
        
        func funcIsHidden(isHiddenBool: Bool) {
            var array = [month_Label,day_Label,date_Label,dateSlash_picture,share_Button,share_picture]
            for n in 0...array.count-1 {
                var ui = array[n]
                ui?.isHidden = isHiddenBool
            }
            userGroup.isHidden = !isHiddenBool
        }
        
        if which == "Group" {
            
            funcIsHidden(isHiddenBool: true)
            
            let getTodayUsername = selectedRunningData["username"] as! String
            userGroup.text = "\(getTodayUsername)さんの今日の記録"
            
        } else if which == "user" || which == "coachHis" {
            
            month1 = UserDefaults.standard.string(forKey: "recordMonth") ?? ""  //UserDefaultに変更
            month2 = Int(month1)!
            if month2 > 9 {
                month_Label.text = "\(month1 ?? "")"
            }else{
                month_Label.text = "0\(month1 ?? "")"
            }
            day1 = UserDefaults.standard.string(forKey: "recordDay")!  //UserDefaultに変更
            day2 = Int(day1)!
            if day2 > 9 {
                day_Label.text = "\(day1 ?? "")"
            } else {
                day_Label.text = "0\(day1 ?? "")"
            }
            
            //Firebase_String で取得・表示
            yobi = selectedRunningData["yobi"] as! String
            date_Label.text = "(\(yobi))"
            
            funcIsHidden(isHiddenBool: false)
            
        }
        
        
        //        let max_temper = selectedRunningData["max_temper"] as! String
        //        maxtemper.text = max_temper
        //        let min_temper = selectedRunningData["min_temper"] as! String
        //        mintemper.text = min_temper
        
        
        
        tableView.reloadData()
        
        
        //menuBody全体を取得
        getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any]
        
        //Firebase_Dictionary で取得・表示
        practicetype_Dictionary = getTodaymenuBody["practiceType"] as? [String:Any] //これを参考に
        menu_Dictionary = getTodaymenuBody["menu"] as? [String:Any]
        upDistance_Dictionary = getTodaymenuBody["upDistance"] as? [String:Any]
        upTime_Dictionary = getTodaymenuBody["upTime"] as? [String:Any]
        downDistance_Dictionary = getTodaymenuBody["downDistance"] as? [String:Any]
        downTime_Dictionary = getTodaymenuBody["downTime"] as? [String:Any]
        
        
        if practicetype_Dictionary[selectedSC] as? String == "" {
            //このタブのデータなし
            let nodata_String = "- - - -"
            
            
            today_practicetype_Label.text = nodata_String
            today_menu_Label.text = nodata_String
            today_up_distance_Label.text = nodata_String
            today_up_time_Label.text = nodata_String
            today_down_distance_Label.text = nodata_String
            today_down_time_Label.text = nodata_String
            
            var selectedSCJP = ""
            
            if selectedSC == "main" {
                selectedSCJP = "本練習"
            } else if selectedSC == "sub" {
                selectedSCJP = "朝練"
            } else if selectedSC == "free" {
                selectedSCJP = "自主練"
            }
            
            OtherHost.alertDef(view: self, title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
        } else {
            
            //このタブのデータあり
            
            today_practicetype_Label.text = practicetype_Dictionary[selectedSC] as? String
            today_menu_Label.text = menu_Dictionary[selectedSC] as? String
            today_up_distance_Label.text =  "\(upDistance_Dictionary[selectedSC] as? String ?? "- - -") m"
            today_up_time_Label.text = upTime_Dictionary[selectedSC] as? String
            today_down_distance_Label.text = "\(downDistance_Dictionary[selectedSC] as? String ?? "- - -") m"
            today_down_time_Label.text = downTime_Dictionary[selectedSC] as? String
            
            
            
            
        }
        
        
        
        //MARK: これのみ例外・String取得・表示
        totalDistance = getTodaymenuBody["totalDistance"] as? String ?? "- - -"
        today_total_distance_Label.text = "\(totalDistance) m"
        
        
        
        //SC
        //        practiceKind_SC.selectedSegmentTintColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0) //選択しているボタンの背景色
        //SC
        practiceKind_SC.selectedSegmentTintColor = Asset.lineColor.color //選択しているボタンの背景色
        
        //        Asset.coachPicture.image
        
        practiceKind_SC.backgroundColor = Asset.whiteColor.color //選択していないボタンの背景色
        
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected) //選択しているボタンのtextColor
        practiceKind_SC.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:Asset.mainColor.color], for: .normal) //選択していないボタンのtextColor
        
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-2" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_2_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData3 = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //menuBody全体を取得
        let getTodaymenuBody = selectedRunningData["menuBody"] as! [String:Any]
        
        //メニュー詳細 - TableView
        let runDetail = getTodaymenuBody["runDetail"] as! [String:Any]
        
        let electedrunDetail = runDetail[selectedSC] as! [String:Any]
        
        let checkRow = electedrunDetail["0"] as! [String:Any]
        
        scrollView_Const.constant = CGFloat(721 + 74*electedrunDetail.count)
        //        tableView_Const.constant = CGFloat(25 + 74*electedrunDetail.count)
        
        if checkRow["distance"] as! String == "" {
            
            noData_Label.isHidden = false
            return 0
            
        } else {
            
            noData_Label.isHidden = true
            return electedrunDetail.count
            
        }
        
        
        
    }
    
    
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! History_1_TableViewCell
        
        //        let cellCount = indexPath.row + 1
        
        //menuBody全体を取得
        getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any]
        
        //メニュー詳細 - TableView
        let runDetail = getTodaymenuBody["runDetail"] as? [String:Any]
        let electedrunDetail = runDetail?[selectedSC] as? [String:Any]
        let lineRunDetail = electedrunDetail?["\(indexPath.row)"] as? [String:Any]
        
        //        let getPracticePoint = runningData_Dictionary2["\(cellCount)"]!["practicePoint"]
        
        cell.distance_TF?.text = "\(lineRunDetail?["distance"] as? String ?? "0") m"
        cell.pace_Label?.text = "\(lineRunDetail?["pace"] as? String ?? "00:00") /km"
        cell.time_Label?.text = lineRunDetail?["time"] as? String
        
        //number_Labelのtext設定
        
        let numberTemprate = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩"]
        if indexPath.row < 10 {
            cell.number_Label?.text = numberTemprate[indexPath.row]
        } else {
            cell.number_Label?.text = "\(indexPath.row + 1)."
        }
        
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //        "\(cellCount)日(\())"
        return cell  //cellの戻り値を設定
    }
    
    
    
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
        
        //menuBody全体を取得
        getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any]
        
        //Firebase_Dictionary で取得・表示
        practicetype_Dictionary = getTodaymenuBody["practiceType"] as? [String:Any]
        menu_Dictionary = getTodaymenuBody["menu"] as? [String:Any]
        upDistance_Dictionary = getTodaymenuBody["upDistance"] as? [String:Any]
        upTime_Dictionary = getTodaymenuBody["upTime"] as? [String:Any]
        downDistance_Dictionary = getTodaymenuBody["downDistance"] as? [String:Any]
        downTime_Dictionary = getTodaymenuBody["downTime"] as? [String:Any]
        
        tableView.reloadData()
        
        if practicetype_Dictionary[selectedSC] as? String == "" {
            //このタブのデータなし
            let nodata_String = "- - - -"
            
            today_practicetype_Label.text = nodata_String
            today_menu_Label.text = nodata_String
            today_up_distance_Label.text = nodata_String
            today_up_time_Label.text = nodata_String
            today_down_distance_Label.text = nodata_String
            today_down_time_Label.text = nodata_String
            
            var selectedPracticeDct = ["main":"本練習","sub":"朝練習","free":"自主練習"]
            var selectedSCJP = selectedPracticeDct[selectedSC] ?? "(不明)"
            
            OtherHost.alertDef(view: self, title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
        } else {
            //このタブのデータあり
            
            today_practicetype_Label.text = practicetype_Dictionary[selectedSC] as? String
            today_menu_Label.text = menu_Dictionary[selectedSC] as? String
            today_up_distance_Label.text = "\(upDistance_Dictionary[selectedSC] as! String) m"
            today_up_time_Label.text = upTime_Dictionary[selectedSC] as? String
            today_down_distance_Label.text = "\(downDistance_Dictionary[selectedSC] as! String) m"
            today_down_time_Label.text = downTime_Dictionary[selectedSC] as? String
            
        }
        
        
    }
    
    @IBAction func share_tapped() {
        
        var shareText_String = "\(month1 ?? "")月\(day1 ?? "")日の記録"
        var electedPracticeJP = ""
        
        var electedPracticeArray = ["main","sub","free"]
        
        for i in 0...electedPracticeArray.count-1 {
            
            var electedPractice = electedPracticeArray[i]
            
            if practicetype_Dictionary[electedPractice] as? String == "" {
                
                //データなしのため飛ばす
                
            } else {
                
                //データあり
                var electedPracticeDct = ["main":"本練習","sub":"朝練習","free":"自主練習"]
                electedPracticeJP = electedPracticeDct[electedPractice] ?? "不明"
                
                var share_practicetype_String = practicetype_Dictionary[electedPractice] as? String
                var share_menu_String = menu_Dictionary[electedPractice] as? String
                var share_up_distance_String = "\(upDistance_Dictionary[electedPractice] as? String ?? "- - -") m"
                var share_up_time_String = upTime_Dictionary[electedPractice] as? String
                var share_down_distance_String = "\(downDistance_Dictionary[electedPractice] as? String ?? "- - -") m"
                var share_down_time_String = downTime_Dictionary[electedPractice] as? String
                
                
                
                
                var share_menuBody_String = ""
                
                
                //menuBody全体を取得
                getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any] ?? [:]
                //メニュー詳細 - TableView
                let runDetail = getTodaymenuBody["runDetail"] as? [String:Any]
                
                let electedrunDetail = runDetail?[electedPractice] as? [String:Any]
                
                
                for tvcount in 0...(electedrunDetail?.count ?? 1)-1 {
                    
                    
                    
                    
                    let lineRunDetail = electedrunDetail?["\(tvcount)"] as? [String:Any]
                    
                    var distanceS = "\(lineRunDetail?["distance"] as? String ?? "0")m"
                    var paceS = "\(lineRunDetail?["pace"] as? String ?? "00:00")/km"
                    var timeS = lineRunDetail?["time"] as? String ?? "00:00"
                    var numberS = ""
                    //number_Labelのtext設定
                    
                    let numberTemprate = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩"]
                    if tvcount < 10 {
                        numberS = numberTemprate[tvcount]
                    } else {
                        numberS = "\(tvcount)."
                    }
                    share_menuBody_String = "\(share_menuBody_String)\(numberS) \(distanceS) \(timeS) (\(paceS))\n"
                    
                }
                
                
                var share_content_String = "\n\(electedPracticeJP)\n練習タイプ：\(share_practicetype_String ?? "")\n内容：\(share_menu_String ?? "")\nアップ：\(share_up_distance_String) \(share_up_time_String ?? "")\nメニュー詳細：\n\(share_menuBody_String)ダウン：\(share_down_distance_String) \(share_down_time_String ?? "")\n"
                
                shareText_String = "\(shareText_String)\(share_content_String)"
                print(shareText_String)
                
            }
        }
        
        
        var share_totaldistance_String = "\(totalDistance) m"
        
        
        
        
        let share_placeType_String = selectedRunningData["placeType"] as! String
        let share_practicePoint_String = selectedRunningData["practicePoint"] as! String
        
        shareText_String = "\(shareText_String)\nトータル距離：\(share_totaldistance_String)\n練習場所タイプ：\(share_placeType_String)\n練習評価：\(share_practicePoint_String)"
        
        
        
        //痛み
        
        let painLevel1 = selectedRunningData["pain"] as? [String: Any]
        let painLevel2 = painLevel1?["painTF"] as? String ?? "痛みなし"
        
        if painLevel2 == "痛みなし" {
            
            shareText_String = "\(shareText_String)\n痛み：なし"
            
            
        } else {
            
            let painLevel = painLevel1?["painLebel"] as! String
            let painWriting = painLevel1?["painWriting"] as! String
            
            shareText_String = "\(shareText_String)\n痛み：あり\n痛みの度合い：\(painLevel)\n痛みの詳細：\(painWriting)"
            
            
        }
        
        
        
        
        let share_mealTime_String = selectedRunningData["mealTime"] as! String
        let share_sleepStart_String = selectedRunningData["sleepStart"] as! String
        let share_sleepEnd_String = selectedRunningData["sleepEnd"] as! String
        let share_tiredLevel_String = selectedRunningData["tiredLevel"] as! String
        let share_writing_String = selectedRunningData["writing"] as! String
        
        
        shareText_String = "\(shareText_String)\n食事：\(share_mealTime_String)\n睡眠：\(share_sleepStart_String) ~ \(share_sleepEnd_String)\n疲労度：\(share_tiredLevel_String)\n\n感想\n\(share_writing_String)"
        
        print("FINISH")
        print("\(shareText_String)")
        
        let shareItems = [shareText_String] as [Any]
        let controller = UIActivityViewController(activityItems:shareItems, applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
    }
    
    
    @IBAction func tap(_ sender: UIButton) {
        otherinfo_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cansel(_ sender: UIButton) {
        otherinfo_picture.image = UIImage(named: "p_rectangle_curbed_L")
        
    }
    @IBAction func otherinfo() {
        otherinfo_picture.image = UIImage(named: "p_rectangle_curbed_L")
        self.performSegue(withIdentifier: "go-his-2", sender: selectedRunningData)
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
