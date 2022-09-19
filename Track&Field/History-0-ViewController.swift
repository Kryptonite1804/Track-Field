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
    var runningData_Dictionary: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]]! = [:]
    
    let dateFormatter = DateFormatter()
    
    var request: UNNotificationRequest!
    

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

        
        Auth.auth().addStateDidChangeListener { (auth, user) in

            guard let user = user else {

                return
            }

            self.userUid = user.uid


            //Adultusersコレクション内の情報を取得
            let docRef2 = self.db.collection("Users").document("\(self.userUid)")

            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data2: \(documentdata2)")


                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)

                    UserDefaults.standard.set(self.groupUid, forKey: "groupUid")  //var. 1.0.2
                    UserDefaults.standard.set(self.userUid, forKey: "userUid")  //var. 1.0.2
                    
                } else {
                    print("Document2 does not exist")

                    self.activityIndicatorView.stopAnimating()  //AIV
                    self.alert(title: "エラー", message: "練習記録のロードに失敗しました。")
                }
            }

        }
        
        
        
       
        
        
        
        
        
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        year.text = "\(todayYear)年"
        month.text = "\(todayMonth)月"
        
        
        self.activityIndicatorView.startAnimating()  //AIV
        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
        let docRef3 = self.db.collection("Users").document("\(self.userUid)")

        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                
                let collectionName = "\(self.todayYear)-\(self.todayMonth)"
                self.runningData_Dictionary = document.data()![collectionName] as? [String: [String:Any]] ?? [:]
                self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                
                print(": \(self.runningData_Dictionary)")
                
                self.table_view.reloadData()
                
                self.monthTotalDistance_Int = 0
                
                //月間トータル距離の計算
                if self.runningData_Dictionary2.count != 0 {
                //月間トータル距離の計算
                for g in 1...self.runningData_Dictionary2.count {
                    let distanceA = self.runningData_Dictionary2["\(g)"]?["menuBody"] as? [String:Any]
                    let distanceB = distanceA?["totalDistance"] as? String ?? "0"
                    let electedTotalDistance = Int(distanceB)!
                    self.monthTotalDistance_Int += electedTotalDistance
                }
                    
                }
                self.monthTotal_Label.text = "\(self.monthTotalDistance_Int)m"
                
                if self.monthTotalDistance_Int > 30000 {
                    
                    //Start_レビュー依頼_ポップアップ
                    SKStoreReviewController.requestReview()
                    
                }
                
                for f in 0...50 {
                    
                    //通知スタート - 朝
                    
                    
                    let getDate_DateType = Date()
                    let getDate2_DateType = Calendar.current.date(byAdding: .day, value: f, to: getDate_DateType)!
                    
                    var targetDate = Calendar.current.dateComponents(
                        [.year, .month, .day, .hour, .minute],
                        from: getDate2_DateType)
                    targetDate.hour = 8
                    targetDate.minute = 0
                    targetDate.second = 0
                    //            targetDate.minute = 00
                    //            targetDate.second = 00
                    print("時刻設定",targetDate)
                    // 直接日時を設定
                    //                    let triggerDate = DateComponents(hour:18, minute:28, second: 30)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)
                    
                    // 通知コンテンツの作成
                    let content = UNMutableNotificationContent()
                    content.title = "おはようございます"
                    content.body = "今日は朝練に取り組みましたか？\n今日の練習をManeasyに登録しましょう！"
                    content.sound = UNNotificationSound.default
                    
                    //通知許可の取得
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: [.alert, .sound, .badge]){
                            (granted, _) in
                            if granted{
                                UNUserNotificationCenter.current().delegate = self
                            }
                        }
                    
                    //通知_開始
                    
                    let getToday = Date()
                    let getToday1 = Calendar.current.date(byAdding: .day, value: f, to: getToday)!
                    
                    
                    self.loadDate_Formatter.dateFormat = "yyyy/M/d"
                    let getDate = self.loadDate_Formatter.string(from: getToday1)
                    // 通知リクエストの作成
                    self.request = UNNotificationRequest.init(
                        identifier: "\(getDate)-M",
                        content: content,
                        trigger: trigger)
                    
                    os_log("setButton")
                    
                    
                    
                    // 通知リクエストの登録
                    let center = UNUserNotificationCenter.current()
                    center.add(self.request)
                    
                    
                    //通知ゴール - 朝
                    
                    
                    
                    //通知スタート - 夜
                    
                    
                    let getDate_DateType2 = Date()
                    let getDate3_DateType = Calendar.current.date(byAdding: .day, value: f, to: getDate_DateType2)!
                    
                    var targetDate2 = Calendar.current.dateComponents(
                        [.year, .month, .day, .hour, .minute],
                        from: getDate3_DateType)
                    targetDate2.hour = 19
                    targetDate2.minute = 0
                    targetDate2.second = 0
                    //            targetDate.minute = 00
                    //            targetDate.second = 00
                    print("時刻設定",targetDate2)
                    // 直接日時を設定
                    //                    let triggerDate = DateComponents(hour:18, minute:28, second: 30)
                    let trigger2 = UNCalendarNotificationTrigger(dateMatching: targetDate2, repeats: false)
                    
                    // 通知コンテンツの作成
                    let content2 = UNMutableNotificationContent()
                    content2.title = "一日お疲れ様でした"
                    content2.body = "今日は練習に取り組みましたか？\n今日の練習をManeasyに登録しましょう！"
                    content2.sound = UNNotificationSound.default
                    
                    
                    
                    let getToday2 = Date()
                    let getToday3 = Calendar.current.date(byAdding: .day, value: f, to: getToday2)!
                    
                    self.loadDate_Formatter.dateFormat = "yyyy/M/d"
                    let getDate2 = self.loadDate_Formatter.string(from: getToday3)
                    
                    // 通知リクエストの作成
                    self.request = UNNotificationRequest.init(
                        identifier: "\(getDate2)-N",
                        content: content2,
                        trigger: trigger2)
                    os_log("setButton")
                    
                    
                    
                    // 通知リクエストの登録
                    let center2 = UNUserNotificationCenter.current()
                    center2.add(self.request)
                    
                    
                    //通知ゴール - 夜
                    
                    
                }
                
                
                
                
                
                self.activityIndicatorView.stopAnimating()  //AIV
                
            } else {
                print("Document3 does not exist")
                print("練習記録一切なし")
                self.activityIndicatorView.stopAnimating()  //AIV
                
                //                self.alert(title: "練習記録がありません", message: "まだ今月の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                
            }
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
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if runningData_Dictionary.count == 0 {
            //データなし
            
            noData_Title.isHidden = false
            noData_Detail.isHidden = false
            noData_Line.isHidden = false
            noData_Icon.isHidden = false
            
        } else {
            //データあり
            noData_Title.isHidden = true
            noData_Detail.isHidden = true
            noData_Line.isHidden = true
            noData_Icon.isHidden = true
            
        }
        
        
        return runningData_Dictionary.count
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! History_0_TableViewCell
        
        var cellCount = indexPath.row
        print("セル: \(cellCount)行目")
        
        cellCount = runningData_Dictionary2.count - cellCount
        print("セル: \(cellCount)日")
        
        let getPracticePoint = runningData_Dictionary2["\(cellCount)"]!["practicePoint"]
        
        
        if getPracticePoint == nil {
            //値なしの場合・記録なしと表示
            
            let getYobi = runningData_Dictionary2["\(cellCount)"]!["yobi"] as! String
            
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            
            cell.menu_Label?.isHidden = true
            cell.distance_Label?.isHidden = true
            cell.point_Label?.isHidden = true
            cell.pain_Label?.isHidden = true
            cell.total_Label?.isHidden = true
            cell.distance_Image?.isHidden = true
            cell.point_Image?.isHidden = true
            cell.pain_Image?.isHidden = true
            
            cell.noData_Label?.isHidden = false
            
            
        } else {
            
            
            cell.point_Label?.text = getPracticePoint as? String
            
            let getYobi = runningData_Dictionary2["\(cellCount)"]!["yobi"] as! String
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            
            let getPain = runningData_Dictionary2["\(cellCount)"]!["pain"] as? [String: Any]
            let getPainTF = getPain?["painTF"] as! String
            
            if getPainTF == "痛みなし" {
                cell.pain_Label?.textColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)
                
            } else if getPainTF == "痛みあり" {
                cell.pain_Label?.textColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
                
            }
            
            cell.pain_Label?.text = getPainTF
            
            let getTodaymenuBody = runningData_Dictionary2["\(cellCount)"]!["menuBody"] as! [String:Any]
            
            let getTodaymenu2 = getTodaymenuBody["menu"] as! [String:Any]
            
            var menu_String = ""
            
            if getTodaymenu2["main"] as! String != "" {
                menu_String = getTodaymenu2["main"] as! String
                
            } else if getTodaymenu2["sub"] as! String != "" {
                menu_String = getTodaymenu2["sub"] as! String
                
            } else if getTodaymenu2["free"] as! String != "" {
                menu_String = getTodaymenu2["free"] as! String
            }
            
            cell.menu_Label?.text = menu_String
            
            let getTotalDistance = getTodaymenuBody["totalDistance"] as! String
            cell.distance_Label?.text = "\(getTotalDistance) m"
            
            
            
            cell.menu_Label?.isHidden = false
            cell.distance_Label?.isHidden = false
            cell.point_Label?.isHidden = false
            cell.pain_Label?.isHidden = false
            cell.total_Label?.isHidden = false
            cell.distance_Image?.isHidden = false
            cell.point_Image?.isHidden = false
            cell.pain_Image?.isHidden = false
            
            cell.noData_Label?.isHidden = true
            
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
        
        getDataKey = runningData_Dictionary2.count - getDataKey
        print("セル: \(getDataKey)日")
        
        let selectedRunningData2 = runningData_Dictionary["\(getDataKey)"]  //選択した行のデータを定数selectedRunningDataに格納
        
        let nilCheck = runningData_Dictionary2["\(getDataKey)"]!["practicePoint"]
        
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
        
        
        year.text = "\(todayYear)年"
        month.text = "\(todayMonth)月"
        
        
        self.activityIndicatorView.startAnimating()  //AIV
        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
        let docRef3 = self.db.collection("Users").document("\(self.userUid)")

        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                
                let collectionName = "\(self.todayYear)-\(self.todayMonth)"
                self.runningData_Dictionary = document.data()![collectionName] as? [String: [String:Any]] ?? [:]
                self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                
                print(": \(self.runningData_Dictionary)")
                
                self.monthTotalDistance_Int = 0
                
                if self.runningData_Dictionary2.count != 0 {
                //月間トータル距離の計算
                for g in 1...self.runningData_Dictionary2.count {
                    let distanceA = self.runningData_Dictionary2["\(g)"]?["menuBody"] as? [String:Any]
                    let distanceB = distanceA?["totalDistance"] as? String ?? "0"
                    let electedTotalDistance = Int(distanceB)!
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
        
        
    }
    
    
    
    
    
    @IBAction func beforemonth() {
        
        var todayYear_Int = Int(todayYear)!
        var todayMonth_Int = Int(todayMonth)!
        
        if todayMonth_Int == 1 {
            
            todayMonth_Int = 12
            todayMonth = "\(todayMonth_Int)"
            
            todayYear_Int -= 1
            todayYear = "\(todayYear_Int)"
            
        } else {
            
            todayMonth_Int -= 1
            todayMonth = "\(todayMonth_Int)"
            
        }
        getData()
        table_view.reloadData()
        
    }
    
    
    
    
    
    @IBAction func aftermonth() {
        
        var todayYear_Int = Int(todayYear)!
        var todayMonth_Int = Int(todayMonth)!
        
        if todayMonth_Int == 12 {
            
            todayMonth_Int = 1
            todayMonth = "\(todayMonth_Int)"
            
            todayYear_Int += 1
            todayYear = "\(todayYear_Int)"
            
        } else {
            
            todayMonth_Int += 1
            todayMonth = "\(todayMonth_Int)"
            
        }
        getData()
        table_view.reloadData()
        
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
