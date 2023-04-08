//
//  CoachHistory-1-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/10.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SafariServices
import StoreKit

class CoachHistory_1_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    
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
    
    let db = Firestore.firestore()
    
    var userUid: String = ""
    
    var username: String = ""
    
    var monthTotalDistance_Int = 0
    
    var runningData_Dictionary: [String:[String:Any]] = [:]
    
    
    var selectedPlayer: [String: Any] = [:]
    
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

        

        self.userUid = selectedPlayer["userUid"] as? String ?? ""
        self.username = selectedPlayer["username"] as? String ?? ""
        navigationItem.title = "\(username)さんの記録"

        UserDefaults.standard.set(self.userUid, forKey: "ElecteduserUid")
        UserDefaults.standard.set(self.userUid, forKey: "Electedusername")


        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        year.text = "\(todayYear)年"
        month.text = "\(todayMonth)月"
        
        
        OtherHost.activityIndicatorView(view: view).startAnimating()  //AIV
        self.userUid = UserDefaults.standard.string(forKey: "ElecteduserUid") ?? "デフォルト値"
        let docRef3 = self.db.collection("Users").document("\(self.userUid)")

        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                
                let collectionName = "\(self.todayYear)-\(self.todayMonth)"
                self.runningData_Dictionary = document.data()![collectionName] as? [String: [String:Any]] ?? [:]
                
                print(": \(self.runningData_Dictionary)")
                
                self.table_view.reloadData()
                
                
                self.monthTotalDistance_Int = 0
                
                if self.runningData_Dictionary.count != 0 {
                    //月間トータル距離の計算
                    for g in 1...self.runningData_Dictionary.count {
                        let distanceA = self.runningData_Dictionary["\(g)"]?["menuBody"] as? [String:Any]
                        let distanceB = distanceA?["totalDistance"] as? String ?? "0"
                        let electedTotalDistance = Int(distanceB)!
                        self.monthTotalDistance_Int += electedTotalDistance
                    }
                    
                }
                self.monthTotal_Label.text = "\(self.monthTotalDistance_Int)m"
                
                if self.monthTotalDistance_Int > 80000 {
                    
                    //Start_レビュー依頼_ポップアップ
                    SKStoreReviewController.requestReview()
                    
                }
                
                OtherHost.activityIndicatorView(view: self.view).stopAnimating()
        
            } else {
                print("Document3 does not exist")
                print("練習記録一切なし")
                OtherHost.activityIndicatorView(view: self.view).stopAnimating()
                
            }
        }
    }
    
    func tvHidden(isHidden: Bool) {
        let uiArray = [noData_Title,noData_Detail,noData_Line,noData_Icon]
        for (ui) in uiArray {
            ui?.isHidden = isHidden
        }
    }
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if runningData_Dictionary.count == 0 {
            //データなし
            tvHidden(isHidden: false)
            
        } else {
            //データあり
            tvHidden(isHidden: true)
        }
        
        return runningData_Dictionary.count
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CoachHistory_1_TableViewCell

        var cellCount = indexPath.row
        print("セル: \(cellCount)行目")
        
        cellCount = runningData_Dictionary.count - cellCount
        print("セル: \(cellCount)日")
        
        let getPracticePoint = runningData_Dictionary["\(cellCount)"]!["practicePoint"]
        
        func funcIsHidden(isHiddenBool: Bool) {
            var array = [cell.menu_Label,cell.distance_Label,cell.point_Label,cell.pain_Label,cell.total_Label,cell.distance_Image,cell.point_Image,cell.pain_Image]
            for (ui) in array {
                ui?.isHidden = isHiddenBool
            }
            cell.noData_Label.isHidden = !isHiddenBool
        }
        
        
        if getPracticePoint == nil {
            //値なしの場合・記録なしと表示
            let getYobi = runningData_Dictionary["\(cellCount)"]!["yobi"] as! String
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            
            funcIsHidden(isHiddenBool: true)
            
        } else {
            
            cell.point_Label?.text = getPracticePoint as? String
            
            let getYobi = runningData_Dictionary["\(cellCount)"]!["yobi"] as! String
            cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
            
            let getPain = runningData_Dictionary["\(cellCount)"]!["pain"] as? [String: Any]
            let getPainTF = getPain?["painTF"] as! String
            
            if getPainTF == "痛みなし" {
                cell.pain_Label?.textColor = Asset.mainColor.color
                
            } else if getPainTF == "痛みあり" {
                cell.pain_Label?.textColor = Asset.subRedColor.color
            }
            
            cell.pain_Label?.text = getPainTF
            
            let getTodaymenuBody = runningData_Dictionary["\(cellCount)"]!["menuBody"] as! [String:Any]
            let getTodaymenu2 = getTodaymenuBody["menu"] as! [String:Any]
            
            var menu_String = ""
            var kindArray = ["free","sub","main"]
            for (kind) in kindArray {
                if getTodaymenu2[kind] as! String != "" {
                    menu_String = getTodaymenu2[kind] as! String
                }
            }
            cell.menu_Label?.text = menu_String
            
            let getTotalDistance = getTodaymenuBody["totalDistance"]
            cell.distance_Label?.text = "\(getTotalDistance as! String) m"
            
            funcIsHidden(isHiddenBool: false)
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
        
        let nilCheck = runningData_Dictionary["\(getDataKey)"]!["practicePoint"]
        
        if nilCheck == nil {
            AlertHost.alertDef(view:self, title: "\(todayMonth)/\(getDataKey)の練習記録はありません", message: "練習記録のある日を選択すると、\nその日のランの詳細を確認できます。")
            
        } else {
            UserDefaults.standard.set(todayMonth, forKey: "recordMonth")
            UserDefaults.standard.set(getDataKey, forKey: "recordDay")
            UserDefaults.standard.set("coachHis", forKey: "which")
            UserDefaults.standard.set(username, forKey: "coachUsername")
            
            performSegue(withIdentifier: "go-his-1", sender: selectedRunningData2)
            
        }
    }
    
    
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "go-his-1" {
            let nextVC = segue.destination as! History_1_ViewController
            nextVC.selectedRunningData = sender as! [String: Any]
        }
    }
    
    
    
    
    func getData() {
        
        let task = Task {
            do {
                
                year.text = "\(todayYear)年"
                month.text = "\(todayMonth)月"
                
                OtherHost.activityIndicatorView(view: view).startAnimating()
                self.userUid = UserDefaults.standard.string(forKey: "ElecteduserUid") ?? "default"
                self.runningData_Dictionary = try await FirebaseClient.shared.getPracticeHistory(year: todayYear, month: todayMonth, documentID: userUid)
                
                self.table_view.reloadData()
                
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
                
                OtherHost.activityIndicatorView(view: view).stopAnimating()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func beforemonth() {
        
        var todayYear_Int = Int(todayYear)!
        var todayMonth_Int = Int(todayMonth)!
        
        if todayMonth_Int == 1 {
            todayMonth_Int = 12
            todayYear_Int -= 1
            todayYear = "\(todayYear_Int)"
            
        } else {
            todayMonth_Int -= 1
        }
        
        todayMonth = "\(todayMonth_Int)"
        getData()
        table_view.reloadData()
    }
    
    
    @IBAction func aftermonth() {
        
        var todayYear_Int = Int(todayYear)!
        var todayMonth_Int = Int(todayMonth)!
        
        if todayMonth_Int == 12 {
            todayMonth_Int = 1
            todayYear_Int += 1
            todayYear = "\(todayYear_Int)"
        } else {
            todayMonth_Int += 1
        }
        
        todayMonth = "\(todayMonth_Int)"
        getData()
        table_view.reloadData()
        
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
