//
//  History-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//要改善


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
        
        func funcIsHidden(isHiddenBool: Bool) {
            let array = [month_Label,day_Label,date_Label,dateSlash_picture,share_Button,share_picture]
            for (ui) in array {
                ui?.isHidden = isHiddenBool
            }
            userGroup.isHidden = !isHiddenBool
        }
        
        //userdefault で取得・表示
        let which: String = UserDefaults.standard.string(forKey: "which") ?? ""
        
        if which == "Group" {
            funcIsHidden(isHiddenBool: true)
            let getTodayUsername = selectedRunningData["username"] as? String ?? "(- - -)"
            userGroup.text = "\(getTodayUsername)さんの今日の記録"
            
        } else if which == "user" || which == "coachHis" {
            month1 = UserDefaults.standard.string(forKey: "recordMonth") ?? "0"
            day1 = UserDefaults.standard.string(forKey: "recordDay") ?? "0"
            
            let uiArray = [month1:month_Label,day1:day_Label]
            for (key, value) in uiArray {
                let intValue = Int(key!) ?? 0
                if intValue > 9 {
                    value?.text = "\(intValue)"
                } else {
                    value?.text = "0\(intValue)"
                }
            }
            
            //Firebase_String で取得・表示
            yobi = selectedRunningData["yobi"] as! String
            date_Label.text = "(\(yobi))"
            funcIsHidden(isHiddenBool: false)
        }
        
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
            let nodataTextArray = [today_practicetype_Label,today_menu_Label,today_up_distance_Label,today_up_time_Label,today_down_distance_Label,today_down_time_Label]
            for (value) in nodataTextArray {
                value?.text = nodata_String
            }
            
            let selectedPracticeDct = ["main":"本練習","sub":"朝練習","free":"自主練習"]
            let selectedSCJP = selectedPracticeDct[selectedSC] ?? "(不明)"
            AlertHost.alertDef(view: self, title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
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
        practiceKind_SC.selectedSegmentTintColor = Asset.lineColor.color //選択しているボタンの背景色
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
        //menuBody全体を取得
        getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any]
        
        //メニュー詳細 - TableView
        let runDetail = getTodaymenuBody["runDetail"] as? [String:Any]
        let electedrunDetail = runDetail?[selectedSC] as? [String:Any]
        let lineRunDetail = electedrunDetail?["\(indexPath.row)"] as? [String:Any]
        
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
        
        return cell  //cellの戻り値を設定
    }
    
    
    
    @IBAction func practiceKind_Selected(_ sender: UISegmentedControl) {
        
        var kindArray = ["sub","main","free"]
        selectedSC = kindArray[sender.selectedSegmentIndex]
        
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
            var nodataTextArray = [today_practicetype_Label,today_menu_Label,today_up_distance_Label,today_up_time_Label,today_down_distance_Label,today_down_time_Label]
            for (value) in nodataTextArray {
                value?.text = nodata_String
            }
            
            let selectedPracticeDct = ["main":"本練習","sub":"朝練習","free":"自主練習"]
            let selectedSCJP = selectedPracticeDct[selectedSC] ?? "(不明)"
            AlertHost.alertDef(view: self, title: "\(selectedSCJP)の記録はありません", message: "この日の\(selectedSCJP)の記録はありません。\n別の練習を選択してください。")
            
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
        
        let electedPracticeArray = ["main","sub","free"]
        
        for (electedPractice) in electedPracticeArray {
            if practicetype_Dictionary[electedPractice] as? String == "" {
                //データなしのため飛ばす
                
            } else {
                //データあり
                let electedPracticeDct = ["main":"本練習","sub":"朝練習","free":"自主練習"]
                electedPracticeJP = electedPracticeDct[electedPractice] ?? "不明"
                
                let share_practicetype_String = practicetype_Dictionary[electedPractice] as? String
                let share_menu_String = menu_Dictionary[electedPractice] as? String
                let share_up_distance_String = "\(upDistance_Dictionary[electedPractice] as? String ?? "- - -") m"
                let share_up_time_String = upTime_Dictionary[electedPractice] as? String
                let share_down_distance_String = "\(downDistance_Dictionary[electedPractice] as? String ?? "- - -") m"
                let share_down_time_String = downTime_Dictionary[electedPractice] as? String
                
                var share_menuBody_String = ""
                
                //menuBody全体を取得
                getTodaymenuBody = selectedRunningData["menuBody"] as? [String:Any] ?? [:]
                //メニュー詳細 - TableView
                let runDetail = getTodaymenuBody["runDetail"] as? [String:Any]
                let electedrunDetail = runDetail?[electedPractice] as? [String:Any]
                
                for tvcount in 0...(electedrunDetail?.count ?? 1)-1 {
                    
                    let lineRunDetail = electedrunDetail?["\(tvcount)"] as? [String:Any]
                    let distanceS = "\(lineRunDetail?["distance"] as? String ?? "0")m"
                    let paceS = "\(lineRunDetail?["pace"] as? String ?? "00:00")/km"
                    let timeS = lineRunDetail?["time"] as? String ?? "00:00"
                    
                    //number_Labelのtext設定
                    var numberS = ""
                    let numberTemprate = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩"]
                    if tvcount < 10 {
                        numberS = numberTemprate[tvcount]
                    } else {
                        numberS = "\(tvcount)."
                    }
                    share_menuBody_String = "\(share_menuBody_String)\(numberS) \(distanceS) \(timeS) (\(paceS))\n"
                    
                }
                
                let share_content_String = "\n\(electedPracticeJP)\n練習タイプ：\(share_practicetype_String ?? "")\n内容：\(share_menu_String ?? "")\nアップ：\(share_up_distance_String) \(share_up_time_String ?? "")\nメニュー詳細：\n\(share_menuBody_String)ダウン：\(share_down_distance_String) \(share_down_time_String ?? "")\n"
                
                shareText_String = "\(shareText_String)\(share_content_String)"
                print(shareText_String)
                
            }
        }
        
        let share_totaldistance_String = "\(totalDistance) m"
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
