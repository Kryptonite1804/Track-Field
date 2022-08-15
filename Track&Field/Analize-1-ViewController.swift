//
//  Analize-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import Charts
import FirebaseAuth
import FirebaseFirestore

class Analize_1_ViewController: UIViewController {
    
    @IBOutlet weak var graphDate_Label: UILabel!
    @IBOutlet weak var graphTitle_Label: UILabel!
    
    @IBOutlet weak var graphDate_picture: UIImageView!
    @IBOutlet weak var graphTitle_picture: UIImageView!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    
    var userUid: String = ""
    var runningData_Dictionary: [String:Any] = [:]
    var runningData_Dictionary2: [String:[String:Any]]! = [:]
    
    
    var element1_String: String = ""
    var element2_String: String = ""
    
    var element1_Kind_String: String = ""
    var element2_Kind_String: String = ""
    
    var startDate_String: String = ""
    var endDate_String: String = ""
    
    var startYear_String: String = ""
    var startMonth_String: String = ""
    var startDay_String: String = ""
    
    var endYear_String: String = ""
    var endMonth_String: String = ""
    var endDay_String: String = ""
    
    
    
    var practiceKind = ["練習場所タイプ":"placeType","食事の回数":"mealTime","チーム":"time","練習タイプ":"practiceType","練習評価":"practicePoint","痛みの度合い":"painLevel","疲労度":"tiredLevel","アップのタイム":"upTime","ダウンのタイム":"downTime","アップの距離":"upDistance","ダウンの距離":"upDistance","トータル距離":"totalDistance","睡眠時間":"sleepStart"]
    
    var element1Array: [String] = []
    var element2Array: [String] = []
    
    var startYear_Int: Int = 0
    var startMonth_Int: Int = 0
    var startDay_Int: Int = 0
    
    var endYear_Int: Int = 0
    var endMonth_Int: Int = 0
    var endDay_Int: Int = 0
    
    var beforeMonth_Int: Int = 0

    let db = Firestore.firestore()
    
    var startDate_Date: Date = NSDate() as Date
    var endDate_Date: Date = NSDate() as Date
    
    let date_Formatter = DateFormatter()
    
    let yearDate_Formatter = DateFormatter()
    let monthDate_Formatter = DateFormatter()
    let dayDate_Formatter = DateFormatter()
    
    var activityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        graphDate_picture.layer.cornerRadius = 15
        graphDate_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        graphDate_picture.layer.borderWidth = 1.0 // 枠線の太さ
        
        graphTitle_picture.layer.cornerRadius = 20
        graphTitle_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        graphTitle_picture.layer.borderWidth = 2.0 // 枠線の太さ
        graphTitle_picture.layer.shadowColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.5).cgColor //　影の色
        graphTitle_picture.layer.shadowOpacity = 0.5  //影の濃さ
        graphTitle_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphTitle_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        graphTitle_picture.layer.shadowColor = UIColor.white.cgColor //　影の色
        graphTitle_picture.layer.shadowOpacity = 1.0  //影の濃さ
        graphTitle_picture.layer.shadowRadius = 2 // 影のぼかし量
        graphTitle_picture.layer.shadowOffset = CGSize(width: -2.0, height: -2.0) // 影の方向
        
        
        date_Formatter.dateFormat = "yyyy年M月d日"
        yearDate_Formatter.dateFormat = "yyyy"
        monthDate_Formatter.dateFormat = "M"
        dayDate_Formatter.dateFormat = "d"
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.activityIndicatorView.startAnimating()  //AIV
        
        element1_String = UserDefaults.standard.string(forKey: "element1_value") ?? ""
        element2_String = UserDefaults.standard.string(forKey: "element2_value") ?? ""
        element1_Kind_String = UserDefaults.standard.string(forKey: "element1_kind") ?? ""
        element2_Kind_String = UserDefaults.standard.string(forKey: "element2_kind") ?? ""
        startDate_String = UserDefaults.standard.string(forKey: "startDate_graph") ?? ""
        endDate_String = UserDefaults.standard.string(forKey: "endDate_graph") ?? ""
       
        print("startDate_String")
        print(startDate_String)
        print("endDate_String")
        print(endDate_String)
        
        graphDate_Label.text = "\(startDate_String) ~ \(endDate_String)"
        
        startDate_Date = date_Formatter.date(from: startDate_String)!
        endDate_Date = date_Formatter.date(from: endDate_String)!
        
        startYear_String =  yearDate_Formatter.string(from: startDate_Date)
        startMonth_String =  monthDate_Formatter.string(from: startDate_Date)
        startDay_String =  dayDate_Formatter.string(from: startDate_Date)
        
        endYear_String =  yearDate_Formatter.string(from: endDate_Date)
        endMonth_String =  monthDate_Formatter.string(from: endDate_Date)
        endDay_String =  dayDate_Formatter.string(from: endDate_Date)
        
        startYear_Int = Int(startYear_String)!
        startMonth_Int = Int(startMonth_String)!
        startDay_Int = Int(startDay_String)!
        
        endYear_Int = Int(endYear_String)!
        endMonth_Int = Int(endMonth_String)!
        endDay_Int = Int(endDay_String)!
        
        
        let elapsedDays = Calendar.current.dateComponents([.day], from: startDate_Date, to: endDate_Date).day!
        print("elapsedDays")
        print(elapsedDays)
        
        for _ in 0...elapsedDays {
            
            startYear_String =  yearDate_Formatter.string(from: startDate_Date)
            startMonth_String =  monthDate_Formatter.string(from: startDate_Date)
            startDate_String =  dayDate_Formatter.string(from: startDate_Date)
            
            startYear_Int = Int(startYear_String)!
            startMonth_Int = Int(startMonth_String)!
            startDay_Int = Int(startDate_String)!
            
            print("beforeMonth_Int")
            print(beforeMonth_Int)
            print("startMonth_Int")
            print(startMonth_Int)
            
//            if startMonth_Int == beforeMonth_Int {
//
//                print("通ったよ")
//
//            } else {
                
                Auth.auth().addStateDidChangeListener { (auth, user) in

                    guard let user = user else {

                        return
                    }

                    self.userUid = user.uid

                    

                    let docRef3 = self.db.collection("Users").document("\(self.userUid)")

                    docRef3.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")
                            
                            print("どうだっ")
                            print("\(self.startYear_Int)-\(self.startMonth_Int)")
                            
                            let collectionName = "\(self.startYear_Int)-\(self.startMonth_Int)"
                            self.runningData_Dictionary = document.data()![collectionName] as? [String: Any] ?? [:]
                            self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                            
                            print("★: \(String(describing: self.runningData_Dictionary2))")
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            let elementKey = self.practiceKind[self.element1_String] ?? "値なし"
                            
                            print("elementKey")
                            print(elementKey)
                            
                            print(self.startDay_Int)
                            
                            print("個デデデ")
                            print(self.runningData_Dictionary)
                            
                            self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                            
                            print("個デデデ")
                            print(self.runningData_Dictionary2)
                            
                            let startDayKey_String = String(self.startDay_Int)
                            
//                            var check = self.runningData_Dictionary2["\(self.startDay_Int)"]
//                            print("これですね")
//                            print(check)
                            
                            let getElement1 = self.runningData_Dictionary2["\(startDayKey_String)"]?["\(elementKey)"] as? String ?? "値なし"
                            
                            let getElement2 = self.runningData_Dictionary2["\(startDayKey_String)"]?["\(String(describing: self.practiceKind[self.element2_Kind_String]))"] as? String ?? "値なし"
                            
                            self.element1Array.append(getElement1)
                            self.element2Array.append(getElement2)
                            
                            
                //            beforeMonth_Int = startMonth_Int
                            
                            self.startDate_Date = Calendar.current.date(byAdding: .day, value: 1, to: self.startDate_Date)!
                            
                            print("element1Array:")
                            print(self.element1Array)
                            print("element2Array:")
                            print(self.element2Array)
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                    
                        } else {
                            print("Document3 does not exist")
                            print("練習記録なし")
                            self.activityIndicatorView.stopAnimating()  //AIV
                            
                            
                        }
                    }
                    
                    

                }
                
//            }  //if startMonth_Int != beforeMonth_Int
            
//            sleep(2)
            
//            let elementKey = practiceKind[element1_String] ?? "値なし"
//
//            print("elementKey")
//            print(elementKey)
//
//            print(startDay_Int)
//
//            print("個デデデ")
//            print(runningData_Dictionary)
//
//            self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
//
//            print("個デデデ")
//            print(runningData_Dictionary2)
//
//            let startDayKey_String = String(startDay_Int)
//
//            var check = runningData_Dictionary2[startDayKey_String]
//            print("これですね")
//            print(check)
//
//            let getElement1 = runningData_Dictionary2["\(startDayKey_String)"]?["\(elementKey)"] as? String ?? "値なし"
//
//            let getElement2 = runningData_Dictionary2["\(startDayKey_String)"]?["\(String(describing: practiceKind[element2_Kind_String]))"] as? String ?? "値なし"
//
//            self.element1Array.append(getElement1)
//            self.element2Array.append(getElement2)
//
//
////            beforeMonth_Int = startMonth_Int
//
//            startDate_Date = Calendar.current.date(byAdding: .day, value: 1, to: startDate_Date)!
//
//            print("getElement1:")
//            print(getElement1)
//            print("getElement2:")
//            print(getElement2)
            
        }
        
        print("element1Array:")
        print(element1Array)
        print("element2Array:")
        print(element2Array)
        
        
        /*
        if element1_Kind_String == "結果" && element2_Kind_String == "項目" {
            //縦軸 : 結果　実数値
            //横軸 : 項目　固定値　1~5
            
            
            
            
            
            
            
            
            
            
            let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
            let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
            let dataSet = BarChartDataSet(entries: entries)
            let data = BarChartData(dataSet: dataSet)
            barChartView.data = data
            
            
            
            
            
            
            
            
            
        } else if element1_Kind_String == "評価" && element2_Kind_String == "評価" {
            
            
            
            
            
        } else if element1_Kind_String == "評価" && element2_Kind_String == "項目" {
            
            
            
            
            
        }*/
    }
    
    
    @IBAction func back() {
        
        self.navigationController?.popViewController(animated: true)
        
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
