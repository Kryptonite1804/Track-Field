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


class History_0_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var table_view: UITableView!
    
    
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

        //現在の料理数表示
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
        return runningData_Dictionary.count
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! History_0_TableViewCell

        let cellCount = indexPath.row + 1
        print("セル",cellCount)
        let getPracticePoint = runningData_Dictionary2["\(cellCount)"]!["practicePoint"]
        cell.point_Label?.text = getPracticePoint as? String
        
        let getYobi = runningData_Dictionary2["\(cellCount)"]!["yobi"] as! String
        cell.date_Label?.text = "\(cellCount)日(\(getYobi))"
        
        let getPain = runningData_Dictionary2["\(cellCount)"]!["pain"] as? [String: Any]
        let getPainTF = getPain?["painTF"] as! String
        cell.pain_Label?.text = getPainTF
        
        let getTodaymene = runningData_Dictionary2["\(cellCount)"]!["practiceType"]
        cell.menu_Label?.text = getTodaymene as? String
        
        let getTotalDistance = runningData_Dictionary2["\(cellCount)"]!["total_Distance"]
        cell.distance_Label?.text = getTotalDistance as? String
        
//        "\(cellCount)日(\())"
        return cell  //cellの戻り値を設定
    }
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let getDataKey = indexPath.row + 1
        let selectedRunningData2 = runningData_Dictionary["\(getDataKey)"]  //選択した行のデータを定数selectedRunningDataに格納
        //ミス:performSegue(withIndentifier: "toDetail", sender: selectedRunningData)
        performSegue(withIdentifier: "go-his-1", sender: selectedRunningData2)
}
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
        }
    }
    
    
    
    
    @IBAction func beforemonth() {
        
    }
    
    @IBAction func aftermonth() {
        
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
