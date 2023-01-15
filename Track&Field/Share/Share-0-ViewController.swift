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


class Share_0_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var noData_Title: UILabel!
    @IBOutlet weak var noData_Detail: UILabel!
    @IBOutlet weak var noData_Line: UIImageView!
    @IBOutlet weak var noData_Icon: UIImageView!
    
    
    let loadDate_Formatter = DateFormatter()  //DP
    var todayYear: String = ""
    var todayMonth: String = ""
    var todayDay: String = ""
    var todayYobi: String = ""
    
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var groupUid: String = ""
    var runningData_Dictionary: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]]! = [:]
    
    let dateFormatter = DateFormatter()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
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
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let task = Task {
            do {
                
                year.text = "\(todayYear)年"
                month.text = "\(todayMonth)月\(todayDay)日(\(todayYobi))"
                
                
                OtherHost.activityIndicatorView(view: view).startAnimating()
                
                self.userUid = try await FirebaseClient.shared.getUUID()
                self.groupUid = try await FirebaseClient.shared.getUserData().groupUid ?? ""
                
                let docRef3 = self.db.collection("Group").document("\(self.groupUid)")
                
                docRef3.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data3: \(documentdata3)")
                        
                        let runningData_Dictionary_A = document.data()?["todayData"] as? [String: [String:Any]] ?? [:]
                        
                        let collectionName = "\(self.todayYear)-\(self.todayMonth)-\(self.todayDay)"
                        self.runningData_Dictionary = runningData_Dictionary_A[collectionName] as? [String: [String:Any]] ?? [:]
                        self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                        
                        print("これでてる: \(self.runningData_Dictionary)")
                        
                        self.table_view.reloadData()
                        OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                        
                    } else {
                        print("Document3 does not exist")
                        print("練習記録なし")
                        OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                        
                        OtherHost.alertDef(view:self, title: "練習記録がありません", message: "まだ今日の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                        
                    }
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        func tVIsHidden(isHiddenBool: Bool) {
            let array = [noData_Title,noData_Detail,noData_Line,noData_Icon]
            for n in 0...array.count-1 {
                let ui = array[n]
                ui?.isHidden = isHiddenBool
            }
        }
        
        
        if runningData_Dictionary.count == 0 {
            //データなし
            tVIsHidden(isHiddenBool: false)
            
        } else {
            //データあり
            tVIsHidden(isHiddenBool: true)
            
        }
        
        return runningData_Dictionary.count
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Share_0_TableViewCell
        
        let cellCount = indexPath.row
        print("セル",cellCount)
        
        let keyArray = Array(runningData_Dictionary2.keys)
        let getkeyArray = keyArray[cellCount]
        
        let getPracticePoint = runningData_Dictionary2["\(getkeyArray)"]?["practicePoint"]
        
        func tVIsHidden(isHiddenBool: Bool) {
            let array = [cell.menu_Label,cell.distance_Label,cell.point_Label,cell.pain_Label,cell.total_Label,cell.distance_Image,cell.point_Image,cell.pain_Image]
            for n in 0...array.count-1 {
                let ui = array[n]
                ui?.isHidden = isHiddenBool
            }
            cell.noData_Label?.isHidden = !isHiddenBool
        }
        
        
        if getPracticePoint == nil {
            //値なしの場合・記録なしと表示
            let getUsername = runningData_Dictionary2["\(getkeyArray)"]?["username"]
            cell.date_Label?.text = "\(getUsername ?? "")"
            tVIsHidden(isHiddenBool: true)
            
        } else {
            
            
            cell.point_Label?.text = getPracticePoint as? String
            
            let getUsername = runningData_Dictionary2["\(getkeyArray)"]?["username"] as? String ?? ""
            cell.date_Label?.text = "\(getUsername)"
            let getPain = runningData_Dictionary2["\(getkeyArray)"]?["pain"] as? [String: Any]
            let getPainTF = getPain?["painTF"] as? String
            
            if getPainTF == "痛みなし" {
                cell.pain_Label?.textColor = Asset.mainColor.color
            } else if getPainTF == "痛みあり" {
                cell.pain_Label?.textColor = Asset.subRedColor.color
            }
            
            cell.pain_Label?.text = getPainTF
            
            let getTodaymenuBody = runningData_Dictionary2["\(getkeyArray)"]?["menuBody"] as? [String:Any]
            let getTodaymenu2 = getTodaymenuBody?["menu"] as? [String:Any] ?? [:]
            var menu_String = ""
            
            if getTodaymenu2["main"] as? String != "" {
                menu_String = getTodaymenu2["main"] as? String ?? ""
                
            } else if getTodaymenu2["sub"] as? String != "" {
                menu_String = getTodaymenu2["sub"] as? String ?? ""
                
            } else if getTodaymenu2["free"] as? String != "" {
                menu_String = getTodaymenu2["free"] as? String ?? ""
            }
            
            cell.menu_Label?.text = menu_String
            
            let getTotalDistance = getTodaymenuBody?["totalDistance"] as? String ?? ""
            cell.distance_Label?.text = "\(getTotalDistance) m"
            
            tVIsHidden(isHiddenBool: false)
            
        }
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //        "\(cellCount)日(\())"
        return cell  //cellの戻り値を設定
    }
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let getDataKey = indexPath.row
        
        let keyArray = Array(runningData_Dictionary2.keys)
        let getkeyArray = keyArray[getDataKey]
        
        let selectedRunningData2 = runningData_Dictionary["\(getkeyArray)"]  //選択した行のデータを定数selectedRunningDataに格納
        
        let nilCheck = runningData_Dictionary2["\(getkeyArray)"]?["practicePoint"]
        
        //        if nilCheck == nil {
        //
        //            alert(title: "この人の練習記録はありません", message: "練習記録のある日を選択すると、\nその日のランの詳細を確認できます。")
        //
        //        } else {
        
        
        UserDefaults.standard.set("Group", forKey: "which")
        
        performSegue(withIdentifier: "go-his-1", sender: selectedRunningData2)
        
        
        //        }
    }
    
    
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData = sender as? [String: Any] ?? [:]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    
    
    
    func getData() {
        
        
        year.text = "\(todayYear)年"
        month.text = "\(todayMonth)月"
        
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
        let docRef3 = self.db.collection("Users").document("\(self.userUid)")
        
        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                
                let collectionName = "\(self.todayYear)-\(self.todayMonth)"
                self.runningData_Dictionary = document.data()?[collectionName] as? [String: [String:Any]] ?? [:]
                self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                
                print(": \(self.runningData_Dictionary)")
                
                self.table_view.reloadData()
                OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                
            } else {
                print("Document3 does not exist")
                print("練習記録なし")
                OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                
                
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
