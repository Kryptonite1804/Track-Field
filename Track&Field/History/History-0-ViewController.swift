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
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var groupUid: String = ""
    var runningData_Dictionary: [String:[String:Any]] = [:]
    var runningData_Dictionary2: [String:[String:Any]]? = [:]
    
    let dateFormatter = DateFormatter()
    
    var request: UNNotificationRequest!
    
    var request2: UNNotificationRequest!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        //TV
        table_view.delegate = self
        table_view.dataSource = self
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        
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
        
        
        
        //MARK: Fclientで対応済のため不要↓
        
//        let task = Task {
//            do {
//                self.userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
//
//                var userData = try await FirebaseClient.shared.getUserData()
//                self.groupUid = userData.groupUid ?? ""
                
                //Adultusersコレクション内の情報を取得
//                let docRef2 = self.db.collection("Users").document("\(self.userUid)")
//
//                docRef2.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data2: \(documentdata2)")
                        
                        
//                        self.groupUid = document.data()!["groupUid"] as! String
//                        print("groupUid: ",self.groupUid)
                        
//                        UserDefaults.standard.set(self.groupUid, forKey: "groupUid")  //var. 1.0.2
//                        UserDefaults.standard.set(self.userUid, forKey: "userUid")  //var. 1.0.2
                        
//                    } else {
//                        print("Document2 does not exist")
//
//                        self.activityIndicatorView.stopAnimating()  //AIV
//                        self.alert(title: "エラー", message: "練習記録のロードに失敗しました。")
//                    }
//                }
                
                
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
        
        //MARK: Fclientで対応済のため不要↑
        
        
        //通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted{
                    print("granted 通知")
                    UNUserNotificationCenter.current().delegate = self
                }
            }
        
        let unc = UNUserNotificationCenter.current()  //設定済の通知の全削除
        unc.removeAllPendingNotificationRequests()  //設定済の通知の全削除
        
        
        let content = UNMutableNotificationContent()
        content.title = "おはようございます"
        content.body = "今日は朝練に取り組みましたか？\n今日の練習をManeasyに登録しましょう！"
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.hour = 8    // 14:00 hours
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
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
        
        
        
        
        let content2 = UNMutableNotificationContent()
        content2.title = "一日お疲れ様でした"
        content2.body = "今日は練習に取り組みましたか？\n今日の練習をManeasyに登録しましょう！"
        
        // Configure the recurring date.
        var dateComponents2 = DateComponents()
        dateComponents2.calendar = Calendar.current
        
        dateComponents2.hour = 19    // 14:00 hours
        
        // Create the trigger as a repeating event.
        let trigger2 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents2, repeats: true)
        
        // Create the request
        let uuidString2 = UUID().uuidString
        let request2 = UNNotificationRequest(identifier: uuidString2,
                                             content: content2, trigger: trigger2)
        
        // Schedule the request with the system.
        let notificationCenter2 = UNUserNotificationCenter.current()
        notificationCenter2.add(request2) { (error2) in
            if error2 != nil {
                // Handle any errors.
                print("通知エラー")
            } else {
                print("エラーなし・通知")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let task = Task {
            do {
                
                
                var userData = try await FirebaseClient.shared.getUserData()
                let userMode_String = userData.mode
                print("mode: \(userMode_String ?? "none - userData.mode")")
                
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        getData()
        
//        year.text = "\(todayYear)年"
//        month.text = "\(todayMonth)月"
//
//
//        self.activityIndicatorView.startAnimating()  //AIV
//        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
//        let docRef3 = self.db.collection("Users").document("\(self.userUid)")
//
//        docRef3.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data3: \(documentdata3)")
//
//
//                let collectionName = "\(self.todayYear)-\(self.todayMonth)"
//                self.runningData_Dictionary = document.data()?[collectionName] as? [String: [String:Any]] ?? [:]
////                self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
//
//                print(": \(self.runningData_Dictionary)")
//
//                self.table_view.reloadData()
//
//                self.monthTotalDistance_Int = 0
//
//                //月間トータル距離の計算
//                if self.runningData_Dictionary.count != 0 {
//                    //月間トータル距離の計算
//                    for g in 1...self.runningData_Dictionary.count {
//                        let distanceA = self.runningData_Dictionary["\(g)"]?["menuBody"] as? [String:Any]
//                        let distanceB = distanceA?["totalDistance"] as? String ?? "0"
//                        let electedTotalDistance = Int(distanceB) ?? 0
//                        self.monthTotalDistance_Int += electedTotalDistance
//                    }
//
//                }
//                self.monthTotal_Label.text = "\(self.monthTotalDistance_Int)m"
//
//                if self.monthTotalDistance_Int > 40000 {
//
//                    //Start_レビュー依頼_ポップアップ
//                    SKStoreReviewController.requestReview()
//
//                }
//
//
//
//                self.activityIndicatorView.stopAnimating()  //AIV
//
//            } else {
//                print("Document3 does not exist")
//                print("練習記録一切なし")
//                self.activityIndicatorView.stopAnimating()  //AIV
//
//                //                self.alert(title: "練習記録がありません", message: "まだ今月の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
//
//            }
//        }
        
        
    }
    
    
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if runningData_Dictionary.count == 0 {
            //データなし
            tVIsHidden(isHiddenBool: false)
        } else {
            //データあり
            tVIsHidden(isHiddenBool: true)
        }
        
        return runningData_Dictionary.count
    }
    
    func tVIsHidden(isHiddenBool: Bool) {
        var array = [noData_Title,noData_Detail,noData_Line,noData_Icon]
        for n in 0...array.count-1 {
            var ui = array[n]
            ui?.isHidden = isHiddenBool
        }
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! History_0_TableViewCell
        
        
        func tVIsHidden2(isHiddenBool: Bool) {
            var array = [cell.menu_Label,cell.distance_Label,cell.point_Label,cell.pain_Label,cell.total_Label,cell.distance_Image,cell.point_Image,cell.pain_Image]
            for n in 0...array.count-1 {
                var ui = array[n]
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
            
            if getTodaymenu2["main"] as? String != "" {
                menu_String = getTodaymenu2["main"] as? String ?? ""
                
            } else if getTodaymenu2["sub"] as? String != "" {
                menu_String = getTodaymenu2["sub"] as? String ?? ""
                
            } else if getTodaymenu2["free"] as? String != "" {
                menu_String = getTodaymenu2["free"] as? String ?? ""
            }
            
            cell.menu_Label?.text = menu_String
            
            let getTotalDistance = getTodaymenuBody["totalDistance"] as! String
            cell.distance_Label?.text = "\(getTotalDistance) m"
            
            tVIsHidden2(isHiddenBool: false)
            
        }
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        
        //        "\(cellCount)日(\())"
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
            
            alert(title: "\(todayMonth)/\(getDataKey)の練習記録はありません", message: "練習記録のある日を選択すると、\nその日のランの詳細を確認できます。")
            
        } else {
            
            
            UserDefaults.standard.set(todayMonth, forKey: "recordMonth")
            UserDefaults.standard.set(getDataKey, forKey: "recordDay")
            UserDefaults.standard.set("user", forKey: "which")
            
            performSegue(withIdentifier: "go-his-1", sender: selectedRunningData2)
            
            
        }
    }
    
    
    //    UserDefaults.standard.set(self.username, forKey: "Setup_username")
    //    let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    
    
    
    func getData() {
        
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        
        let task = Task {
            do {
                
                self.userUid = try await FirebaseClient.shared.getUUID()
                
                year.text = "\(todayYear)年"
                month.text = "\(todayMonth)月"
                
                let docRef3 = self.db.collection("Users").document("\(self.userUid)")
                
                docRef3.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data3: \(documentdata3)")
                        
                        
                        let collectionName = "\(self.todayYear)-\(self.todayMonth)"
                        self.runningData_Dictionary = document.data()![collectionName] as? [String: [String:Any]] ?? [:]
                        
                        print(": \(self.runningData_Dictionary)")
                        
                        self.monthTotalDistance_Int = 0
                        
                        if self.runningData_Dictionary.count != 0 {
                            //月間トータル距離の計算
                            for g in 1...self.runningData_Dictionary.count {
                                let distanceA = self.runningData_Dictionary["\(g)"]?["menuBody"] as? [String:Any]
                                let distanceB = distanceA?["totalDistance"] as? String ?? "0"
                                let electedTotalDistance = Int(distanceB) ?? 0
                                self.monthTotalDistance_Int += electedTotalDistance
                            }
                            
                        }
                        self.monthTotal_Label.text = "\(self.monthTotalDistance_Int)m"
                        
                        
                        
                        self.table_view.reloadData()
                        self.activityIndicatorView.stopAnimating()  //AIV
                        
                    } else {
                        print("Document3 does not exist")
                        print("練習記録なし")
                        self.activityIndicatorView.stopAnimating()  //AIV
                        
                        self.alert(title: "練習記録がありません", message: "まだこの月の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                        
                    }
                }
                
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
        
        let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
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
