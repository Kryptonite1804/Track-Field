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


class Share_0_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
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
    
    var activityIndicatorView = UIActivityIndicatorView()
    let db = Firestore.firestore()
    
    var userUid: String = ""
    var groupUid: String = ""
    var runningData_Dictionary: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]]! = [:]
    
    let dateFormatter = DateFormatter()
    
    
    

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
        month.text = "\(todayMonth)月\(todayDay)日(\(todayYobi))"
        
        
        self.activityIndicatorView.startAnimating()  //AIV
        self.userUid = UserDefaults.standard.string(forKey: "userUid") ?? "デフォルト値"
        self.groupUid = UserDefaults.standard.string(forKey: "groupUid") ?? "デフォルト値"
        
        let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

        docRef3.getDocument { (document, error) in
            if let document = document, document.exists {
                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data3: \(documentdata3)")
                
                let runningData_Dictionary_A = document.data()!["todayData"] as? [String: [String:Any]] ?? [:]
                
                let collectionName = "\(self.todayYear)-\(self.todayMonth)-\(self.todayDay)"
                self.runningData_Dictionary = runningData_Dictionary_A[collectionName] as? [String: [String:Any]] ?? [:]
                self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                
                print("これでてる: \(self.runningData_Dictionary)")
                
                self.table_view.reloadData()
                self.activityIndicatorView.stopAnimating()  //AIV
        
            } else {
                print("Document3 does not exist")
                print("練習記録なし")
                self.activityIndicatorView.stopAnimating()  //AIV
                
                self.alert(title: "練習記録がありません", message: "まだ今日の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Share_0_TableViewCell

        let cellCount = indexPath.row
        print("セル",cellCount)
        
        let keyArray = Array(runningData_Dictionary2.keys)
        let getkeyArray = keyArray[cellCount]
        
        let getPracticePoint = runningData_Dictionary2["\(getkeyArray)"]!["practicePoint"]
        
        
        if getPracticePoint == nil {
            //値なしの場合・記録なしと表示
            
            
            let getUsername = runningData_Dictionary2["\(getkeyArray)"]!["username"]
            cell.date_Label?.text = "\(getUsername ?? "")"
            
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
        
        let getUsername = runningData_Dictionary2["\(getkeyArray)"]!["username"] as! String
        cell.date_Label?.text = "\(getUsername)"
        
        let getPain = runningData_Dictionary2["\(getkeyArray)"]!["pain"] as? [String: Any]
        let getPainTF = getPain?["painTF"] as! String
            
            if getPainTF == "痛みなし" {
                cell.pain_Label?.textColor = UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)
                
            } else if getPainTF == "痛みあり" {
                cell.pain_Label?.textColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 1.0)
                
            }
            
        cell.pain_Label?.text = getPainTF
        
            let getTodaymenuBody = runningData_Dictionary2["\(getkeyArray)"]!["menuBody"] as! [String:Any]
            
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
        
        let getTotalDistance = getTodaymenuBody["totalDistance"]
        cell.distance_Label?.text = "\(getTotalDistance as! String) m"
            
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
        
        let getDataKey = indexPath.row
        
        let keyArray = Array(runningData_Dictionary2.keys)
        let getkeyArray = keyArray[getDataKey]
        
        let selectedRunningData2 = runningData_Dictionary["\(getkeyArray)"]  //選択した行のデータを定数selectedRunningDataに格納
        
        let nilCheck = runningData_Dictionary2["\(getkeyArray)"]!["practicePoint"]
        
        if nilCheck == nil {
            
            alert(title: "この人の練習記録はありません", message: "練習記録のある日を選択すると、\nその日のランの詳細を確認できます。")
            
        } else {
            
            
            UserDefaults.standard.set("Group", forKey: "which")
        
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
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}