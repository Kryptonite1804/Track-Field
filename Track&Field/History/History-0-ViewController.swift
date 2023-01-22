//
//  History-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SafariServices
import os
import StoreKit
import UserNotifications


class History_0_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate, UNUserNotificationCenterDelegate {
    
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var noData_Title: UILabel!
    @IBOutlet weak var noData_Detail: UILabel!
    @IBOutlet weak var noData_Line: UIImageView!
    @IBOutlet weak var noData_Icon: UIImageView!
    
    @IBOutlet weak var monthTotal_Label: UILabel!
    
    let loadDate_Formatter = DateFormatter()  //DP
    var todayYear: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    var monthTotalDistance_Int = 0
    
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var groupUid: String = ""
    var runningData_Dictionary: [String:[String:Any]] = [:]
    
    let dateFormatter = DateFormatter()
    
    var request: UNNotificationRequest!
    
    var request2: UNNotificationRequest!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TV
        table_view.delegate = self
        table_view.dataSource = self
        
        //date
        let today = Date()
        loadDate_Formatter.locale = Locale(identifier: "ja_JP")
        
        loadDate_Formatter.dateFormat = "yyyy"
        todayYear = loadDate_Formatter.string(from: today)
        
        loadDate_Formatter.dateFormat = "M"
        todayMonth = loadDate_Formatter.string(from: today)
        
        loadDate_Formatter.dateFormat = "d"
        todayDay = loadDate_Formatter.string(from: today)
        
        loadDate_Formatter.dateFormat = "E"
        todayYobi = loadDate_Formatter.string(from: today)
        
        //通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted {
                    print("granted 通知")
                    UNUserNotificationCenter.current().delegate = self
                }
            }
        let unc = UNUserNotificationCenter.current()  //設定済の通知の全削除
        unc.removeAllPendingNotificationRequests()  //設定済の通知の全削除
        
        
        func notificationSet(title: String, body: String, hour: Int) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = hour
            
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // Create the request
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content, trigger: trigger)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                    print("通知エラー")
                } else {
                    print("エラーなし・通知")
                }
            }
        }
        
        notificationSet(title: "おはようございます", body: "今日は朝練に取り組みましたか？\n今日の練習をManeasyに登録しましょう！", hour: 8)
        notificationSet(title: "一日お疲れ様でした", body: "今日は練習に取り組みましたか？\n今日の練習をManeasyに登録しましょう！", hour: 19)
        
        // Configure the recurring date.
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if runningData_Dictionary.count == 0 {
            tVIsHidden(isHiddenBool: false) //データなし
        } else {
            tVIsHidden(isHiddenBool: true) //データあり
        }
        return runningData_Dictionary.count
    }
    
    
    func tVIsHidden(isHiddenBool: Bool) {
        let array = [noData_Title,noData_Detail,noData_Line,noData_Icon]
        for (ui) in array {
            ui?.isHidden = isHiddenBool
        }
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! History_0_TableViewCell
        
        func tVIsHidden2(isHiddenBool: Bool) {
            let array = [cell.menu_Label,cell.distance_Label,cell.point_Label,cell.pain_Label,cell.total_Label,cell.distance_Image,cell.point_Image,cell.pain_Image]
            for (ui) in array {
                ui?.isHidden = isHiddenBool
            }
            cell.noData_Label?.isHidden = !isHiddenBool
        }
        
        
        var cellCount = indexPath.row
        print("セル: \(cellCount)行目")
        cellCount = runningData_Dictionary.count - cellCount
        print("セル: \(cellCount)日")
        
        let getPracticePoint = runningData_Dictionary["\(cellCount)"]?["practicePoint"]
        
        if getPracticePoint == nil {
            //値なしの場合・記録なしと表示
            let getYobi = runningData_Dictionary["\(cellCount)"]?["yobi"] as? String ?? ""
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            tVIsHidden2(isHiddenBool: true)
            
        } else {
            cell.point_Label?.text = getPracticePoint as? String
            
            let getYobi = runningData_Dictionary["\(cellCount)"]?["yobi"] as? String ?? ""
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            
            let getPain = runningData_Dictionary["\(cellCount)"]?["pain"] as? [String: Any]
            let getPainTF = getPain?["painTF"] as! String
            if getPainTF == "痛みなし" {
                cell.pain_Label?.textColor = Asset.mainColor.color
            } else if getPainTF == "痛みあり" {
                cell.pain_Label?.textColor = Asset.subRedColor.color
            }
            cell.pain_Label?.text = getPainTF
            
            let getTodaymenuBody = runningData_Dictionary["\(cellCount)"]?["menuBody"] as? [String:Any] ?? [:]
            let getTodaymenu2 = getTodaymenuBody["menu"] as? [String:Any] ?? [:]
            
            var menu_String = ""
            
            let arrayKind = ["main","sub","free"]
            for (electedKind) in arrayKind {
                if getTodaymenu2[electedKind] as? String != "" {
                    menu_String = getTodaymenu2[electedKind] as? String ?? ""
                }
            }
            
            cell.menu_Label?.text = menu_String
            
            let getTotalDistance = getTodaymenuBody["totalDistance"] as! String
            cell.distance_Label?.text = "\(getTotalDistance) m"
            
            tVIsHidden2(isHiddenBool: false)
        }
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell  //cellの戻り値を設定
    }
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        var getDataKey = indexPath.row
        print("セル: \(getDataKey)行目")
        
        getDataKey = runningData_Dictionary.count - getDataKey
        print("セル: \(getDataKey)日")
        
        let selectedRunningData2 = runningData_Dictionary["\(getDataKey)"]  //選択した行のデータを定数selectedRunningDataに格納
        
        let nilCheck = runningData_Dictionary["\(getDataKey)"]?["practicePoint"]
        
        if nilCheck == nil {
            AlertHost.alertDef(view: self, title: "\(todayMonth)/\(getDataKey)の練習記録はありません", message: "練習記録のある日を選択すると、\nその日のランの詳細を確認できます。")
            
        } else {
            UserDefaults.standard.set(todayMonth, forKey: "recordMonth")
            UserDefaults.standard.set(getDataKey, forKey: "recordDay")
            UserDefaults.standard.set("user", forKey: "which")
            performSegue(withIdentifier: "go-his-1", sender: selectedRunningData2)
        }
    }
    
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    
    func getData() {
        let task = Task {
            do {
                year.text = "\(todayYear)年"
                month.text = "\(todayMonth)月"
                
                self.runningData_Dictionary = try await FirebaseClient.shared.getPracticeHistory(year: todayYear, month: todayMonth)
                self.monthTotalDistance_Int = 0
                
                if self.runningData_Dictionary.count != 0 {
                    //月間トータル距離の計算
                    for g in 1...self.runningData_Dictionary.count {
                        let distanceA = self.runningData_Dictionary["\(g)"]?["menuBody"] as? [String:Any]
                        let distanceB = distanceA?["totalDistance"] as? String ?? "0"
                        self.monthTotalDistance_Int += Int(distanceB)!
                    }
                }
                
                self.monthTotal_Label.text = "\(self.monthTotalDistance_Int)m"
                self.table_view.reloadData()
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    @IBAction func beforemonth() {
        
        var todayYear_Int = Int(todayYear) ?? 0
        var todayMonth_Int = Int(todayMonth) ?? 0
        
        if todayMonth_Int == 1 {
            todayMonth_Int = 12
            todayYear_Int -= 1
            todayYear = "\(todayYear_Int)"
        } else {
            todayMonth_Int -= 1
        }
        todayMonth = "\(todayMonth_Int)"
        getData()
    }
    
    
    
    
    
    @IBAction func aftermonth() {
        
        var todayYear_Int = Int(todayYear) ?? 0
        var todayMonth_Int = Int(todayMonth) ?? 0
        
        if todayMonth_Int == 12 {
            todayMonth_Int = 1
            todayYear_Int += 1
            todayYear = "\(todayYear_Int)"
        } else {
            todayMonth_Int += 1
        }
        todayMonth = "\(todayMonth_Int)"
        getData()
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
