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
    
    
    
    var practiceKind = ["食事の回数":"mealTime","練習場所タイプ":"placeType","練習評価":"practicePoint","疲労度":"tiredLevel"
                        ,"トータル距離":"totalDistance" //[menuBody]
                        ,"チーム":"team","練習タイプ":"practiceType","アップのタイム":"upTime","ダウンのタイム":"downTime","アップの距離":"upDistance","ダウンの距離":"downDistance" //[menuBody][""][main,sub,free]
                        ,"痛みの度合い":"painLevel"  //[pain]
                        /*,"睡眠時間":"sleepStart"*/
    ]
    
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
        
        for p in 0...elapsedDays {
            
            
//
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
                            
                            
                            
                            
                            self.startYear_String =  self.yearDate_Formatter.string(from: self.startDate_Date)
                            self.startMonth_String =  self.monthDate_Formatter.string(from: self.startDate_Date)
                            self.startDate_String =  self.dayDate_Formatter.string(from: self.startDate_Date)
                            
                            self.startYear_Int = Int(self.startYear_String)!
                            self.startMonth_Int = Int(self.startMonth_String)!
                            self.startDay_Int = Int(self.startDate_String)!
                            
                            print("beforeMonth_Int")
                            print(self.beforeMonth_Int)
                            print("startMonth_Int")
                            print(self.startMonth_Int)
                            
                            self.startDate_Date = Calendar.current.date(byAdding: .day, value: 1, to: self.startDate_Date)!
                            
                            
                            
                            
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")
                            
                            print("どうだっ")
                            print("\(self.startYear_Int)-\(self.startMonth_Int)")
                            
                            let collectionName = "\(self.startYear_Int)-\(self.startMonth_Int)"
                            self.runningData_Dictionary = document.data()![collectionName] as? [String: Any] ?? [:]
                            self.runningData_Dictionary2 = self.runningData_Dictionary as?[String: [String:Any]]
                            
                            print("★: \(String(describing: self.runningData_Dictionary2))")
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            let elementKey1 = self.practiceKind[self.element1_String] ?? "値なし"
                            
                            print("elementKey1")
                            print(elementKey1)
                            
                            let elementKey2 = self.practiceKind[self.element2_String] ?? "値なし"
                            
                            print("elementKey2")
                            print(elementKey2)
                            
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
                            
                            
//                            ["食事の回数":"mealTime","練習場所タイプ":"placeType","練習評価":"practicePoint","疲労度":"tiredLevel"
//                                                ,"トータル距離":"totalDistance" //[menuBody]
//                                                ,"チーム":"team","練習タイプ":"practiceType","アップのタイム":"upTime","ダウンのタイム":"downTime","アップの距離":"upDistance","ダウンの距離":"upDistance" //[menuBody][""][main,sub,free]
//                                                ,"痛みの度合い":"painLevel"  //[pain]
//                                                /*,"睡眠時間":"sleepStart"*/
//                            ]
                            
                            var getElement1 = ""
                            var getElement2 = ""
                            
                            if elementKey1 == "totalDistance" {
                                
                                let getElement1Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["menuBody"] as? [String:Any] ?? [:]
                                
                                getElement1 = getElement1Prepare["\(elementKey1)"] as? String ?? "0"
                                
                            } else if elementKey1 == "painLevel" {
                                
                                let getElement1Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["pain"] as? [String:Any] ?? [:]
                                
                                getElement1 = getElement1Prepare["\(elementKey1)"] as? String ?? "0"
                                
                                
                                
                            } else if elementKey1 == "team" || elementKey1 == "practiceType" || elementKey1 == "upTime" || elementKey1 == "downTime" || elementKey1 == "upDistance" || elementKey1 == "downDistance" {
                                
                                let getElement1Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["menuBody"] as? [String:Any] ?? [:]
                                
                                let getElement1PrepareS = getElement1Prepare["\(elementKey1)"] as? [String:Any] ?? [:]
                                
                                getElement1 = getElement1PrepareS["main"] as? String ?? "0"
                                
                                if getElement1 == "" || getElement1 == "0" {
                                    getElement1 = getElement1PrepareS["sub"] as? String ?? "0"
                                    
                                    if getElement1 == "" || getElement1 == "0" {
                                        getElement1 = getElement1PrepareS["free"] as? String ?? "0"
                                        if getElement1 == "" {
                                            getElement1 = "0"
                                        }
                                    }
                                    
                                }
                                
                            } else {
                                
                                
                                getElement1 = self.runningData_Dictionary2["\(startDayKey_String)"]?["\(elementKey1)"] as? String ?? "0"
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                            if elementKey2 == "totalDistance" {
                                
                                let getElement2Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["menuBody"] as? [String:Any] ?? [:]
                                
                                getElement2 = getElement2Prepare["\(elementKey2)"] as? String ?? "0"
                                
                            } else if elementKey2 == "painLevel" {
                                
                                let getElement2Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["pain"] as? [String:Any] ?? [:]
                                
                                getElement2 = getElement2Prepare["\(elementKey2)"] as? String ?? "0"
                                
                                
                                
                                
                            } else if elementKey2 == "team" || elementKey2 == "practiceType" || elementKey2 == "upTime" || elementKey2 == "downTime" || elementKey2 == "upDistance" || elementKey2 == "downDistance" {
                                
                                let getElement2Prepare = self.runningData_Dictionary2["\(startDayKey_String)"]?["menuBody"] as? [String:Any] ?? [:]
                                
                                let getElement2PrepareS = getElement2Prepare["\(elementKey2)"] as? [String:Any] ?? [:]
                                
                                getElement2 = getElement2PrepareS["main"] as? String ?? "0"
                                
                                if getElement2 == "" || getElement2 == "0" {
                                    getElement2 = getElement2PrepareS["sub"] as? String ?? "0"
                                    
                                    if getElement2 == "" || getElement2 == "0" {
                                        getElement2 = getElement2PrepareS["free"] as? String ?? "0"
                                        if getElement2 == "" {
                                            getElement2 = "0"
                                        }
                                    }
                                    
                                }
                                
                            } else {
                                
                                
                                getElement2 = self.runningData_Dictionary2["\(startDayKey_String)"]?["\(elementKey2)"] as? String ?? "0"
                                
                                
                                
                            }
                            
                            
                            if getElement1 == "★★★★★" {
                                getElement1 = "5"
                            } else if getElement1 == "★★★★☆" {
                                getElement1 = "4"
                            } else if getElement1 == "★★★☆☆" {
                                getElement1 = "3"
                            } else if getElement1 == "★★☆☆☆" {
                                getElement1 = "2"
                            } else if getElement1 == "★☆☆☆☆" {
                                getElement1 = "1"
                            }
                            
                            if getElement2 == "★★★★★" {
                                getElement2 = "5"
                            } else if getElement2 == "★★★★☆" {
                                getElement2 = "4"
                            } else if getElement2 == "★★★☆☆" {
                                getElement2 = "3"
                            } else if getElement2 == "★★☆☆☆" {
                                getElement2 = "2"
                            } else if getElement2 == "★☆☆☆☆" {
                                getElement2 = "1"
                            }
                            
                            if getElement1 == "余力あり 5" {
                                getElement1 = "5"
                            } else if getElement1 == "余力ややあり 4" {
                                getElement1 = "4"
                            } else if getElement1 == "やや疲れた 3" {
                                getElement1 = "3"
                            } else if getElement1 == "疲れた 2" {
                                getElement1 = "2"
                            } else if getElement1 == "かなり疲れた 1" {
                                getElement1 = "1"
                            }
                            
                            if getElement2 == "余力あり 5" {
                                getElement2 = "5"
                            } else if getElement2 == "余力ややあり 4" {
                                getElement2 = "4"
                            } else if getElement2 == "やや疲れた 3" {
                                getElement2 = "3"
                            } else if getElement2 == "疲れた 2" {
                                getElement2 = "2"
                            } else if getElement2 == "かなり疲れた 1" {
                                getElement2 = "1"
                            }
                            
                            if getElement1 == "5回" {
                                getElement1 = "5"
                            } else if getElement1 == "4回" {
                                getElement1 = "4"
                            } else if getElement1 == "3回" {
                                getElement1 = "3"
                            } else if getElement1 == "2回" {
                                getElement1 = "2"
                            } else if getElement1 == "1回" {
                                getElement1 = "1"
                            }
                            
                            if getElement2 == "5回" {
                                getElement2 = "5"
                            } else if getElement2 == "4回" {
                                getElement2 = "4"
                            } else if getElement2 == "3回" {
                                getElement2 = "3"
                            } else if getElement2 == "2回" {
                                getElement2 = "2"
                            } else if getElement2 == "1回" {
                                getElement2 = "1"
                            }
                           
                            
                            
                            if getElement1 == "余力あり 5" {
                                getElement1 = "5"
                            } else if getElement1 == "余力ややあり 4" {
                                getElement1 = "4"
                            } else if getElement1 == "やや疲れた 3" {
                                getElement1 = "3"
                            } else if getElement1 == "疲れた 2" {
                                getElement1 = "2"
                            } else if getElement1 == "かなり疲れた 1" {
                                getElement1 = "1"
                            }
                            
                            if getElement2 == "余力あり 5" {
                                getElement2 = "5"
                            } else if getElement2 == "余力ややあり 4" {
                                getElement2 = "4"
                            } else if getElement2 == "やや疲れた 3" {
                                getElement2 = "3"
                            } else if getElement2 == "疲れた 2" {
                                getElement2 = "2"
                            } else if getElement2 == "かなり疲れた 1" {
                                getElement2 = "1"
                            }
                            
                            
                            self.element1Array.append(getElement1)
                            self.element2Array.append(getElement2)
                            print("これで終わかなり")
                            print(p)
                            
                //            beforeMonth_Int = startMonth_Int
                            
//                            self.startDate_Date = Calendar.current.date(byAdding: .day, value: 1, to: self.startDate_Date)!
                            
                            print("element1Array:")
                            print(self.element1Array)
                            print("element2Array:")
                            print(self.element2Array)
                            
                            func graf_Kind1(rawData:[Double]) {
                                
                                
                                let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset+1), y: Double($0.element)) }
                                let dataSet = BarChartDataSet(entries: entries)
                                dataSet.drawValuesEnabled = false
                                dataSet.colors = [UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)]
                                let data = BarChartData(dataSet: dataSet)
                                self.barChartView.data = data
                                // ラベルの数を設定
                                self.barChartView.xAxis.labelCount = 5
                                //凡例の非表示
                                self.barChartView.legend.enabled = false
                                // X軸のラベルの位置を下に設定
                                self.barChartView.xAxis.labelPosition = .bottom
                                // X軸のラベルの色を設定
                                self.barChartView.xAxis.labelTextColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
                                // X軸の線、グリッドを非表示にする
                                self.barChartView.xAxis.drawGridLinesEnabled = false
                                self.barChartView.xAxis.drawAxisLineEnabled = false
                                // 右側のY座標軸は非表示にする
                                self.barChartView.rightAxis.enabled = false
                                
                                // Y座標の値が0始まりになるように設定
                                self.barChartView.leftAxis.axisMinimum = 0.0
                                self.barChartView.leftAxis.drawZeroLineEnabled = true
                                self.barChartView.leftAxis.zeroLineColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
                                
                                // ラベルの色を設定
                                self.barChartView.leftAxis.labelTextColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
                                // グリッドの色を設定
                                self.barChartView.leftAxis.gridColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
                                // 軸線は非表示にする
                                self.barChartView.leftAxis.drawAxisLineEnabled = false
                                
                                self.barChartView.pinchZoomEnabled = false // ピンチズーム不可
                                self.barChartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
                                self.barChartView.highlightPerTapEnabled = false // プロットをタップして選択不可
                                
                                self.barChartView.animate(xAxisDuration: 2) // 2秒かけてアニメーション表示
                                
                                
                            }
                            
                            if p == elapsedDays {
                            
                            
                            if self.element1_Kind_String == "結果" && self.element2_Kind_String == "項目" {
                                //縦軸 : 結果　実数値
                                //横軸 : 項目　固定値　1~5
                                //棒グラフ
                                
                                
                                
                                
                                
                                
                                
                                
                            } else if self.element1_Kind_String == "結果" && self.element2_Kind_String == "評価" {
                                //やり方①
                                //縦軸 : 結果　平均値
                                //横軸 : 評価　固定値　1~5
                                //種別 : 棒グラフ
                                
                                var rawData: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
                                
                                for n in 0...self.element2Array.count-1 {
                                    
                                    let element2Array_Content_S = self.element2Array[n]
                                    let element1Array_Content_S = self.element1Array[n]
                                    
                                    let element2Array_Content_I = Int(element2Array_Content_S) ?? 0
                                    let element1Array_Content_D = Double(element1Array_Content_S) ?? 0
                                    
                                    rawData[element2Array_Content_I-1] += element1Array_Content_D
                                    
                                }
                                
                                graf_Kind1(rawData: rawData)
                                
                                
                            } else if self.element1_Kind_String == "評価" && self.element2_Kind_String == "評価" {
                                //やり方①
                                //縦軸 : 評価　平均値
                                //横軸 : 評価　固定値　1~5
                                //種別 : 棒グラフ
                                
                                var rawData: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
                                
                                for n in 0...self.element2Array.count-1 {
                                    
                                    let element2Array_Content_S = self.element2Array[n]
                                    let element1Array_Content_S = self.element1Array[n]
                                    
                                    let element2Array_Content_I = Int(element2Array_Content_S) ?? 0
                                    let element1Array_Content_D = Double(element1Array_Content_S) ?? 0
                                    
                                    rawData[element2Array_Content_I-1] += element1Array_Content_D
                                    
                                }
                                
                                graf_Kind1(rawData: rawData)
                                
                                
                                
                                
                            } else if self.element1_Kind_String == "評価" && self.element2_Kind_String == "項目" {
                                
                                
                                
                                
                                
                            } else if self.element1_Kind_String == "結果" && self.element2_Kind_String == "結果" {
                                
                                
                                
                                
                                
                            }
                                
                                self.activityIndicatorView.stopAnimating()  //AIV
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                    
                        } else {
                            print("Document3 does not exist")
                            print("練習記録なし")
                            self.activityIndicatorView.stopAnimating()  //AIV
                            
                            
                        }
                    }
                    
                    

                }
            
            print("これで一度終わり")
            print(p)
            
            
            
        }
        
        //ここまで - データ一つ一つの取り出し
        
        print("element1Array:")
        print(element1Array)
        print("element2Array:")
        print(element2Array)
        
//        let rawData: [Int] = [20, 50, 70, 30, 60]
//        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset+1), y: Double($0.element)) }
//        let dataSet = BarChartDataSet(entries: entries)
//        dataSet.drawValuesEnabled = false
//        dataSet.colors = [UIColor(red: 162/255, green: 90/255, blue: 239/255, alpha: 1.0)]
//        let data = BarChartData(dataSet: dataSet)
//        barChartView.data = data
//        // ラベルの数を設定
//        barChartView.xAxis.labelCount = 5
//        //凡例の非表示
//        barChartView.legend.enabled = false
//        // X軸のラベルの位置を下に設定
//        barChartView.xAxis.labelPosition = .bottom
//        // X軸のラベルの色を設定
//        barChartView.xAxis.labelTextColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
//        // X軸の線、グリッドを非表示にする
//        barChartView.xAxis.drawGridLinesEnabled = false
//        barChartView.xAxis.drawAxisLineEnabled = false
//        // 右側のY座標軸は非表示にする
//        barChartView.rightAxis.enabled = false
//
//        // Y座標の値が0始まりになるように設定
//        barChartView.leftAxis.axisMinimum = 0.0
//        barChartView.leftAxis.drawZeroLineEnabled = true
//        barChartView.leftAxis.zeroLineColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
//
//        // ラベルの色を設定
//        barChartView.leftAxis.labelTextColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
//        // グリッドの色を設定
//        barChartView.leftAxis.gridColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75)
//        // 軸線は非表示にする
//        barChartView.leftAxis.drawAxisLineEnabled = false
//
//        barChartView.pinchZoomEnabled = false // ピンチズーム不可
//        barChartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
//        barChartView.highlightPerTapEnabled = false // プロットをタップして選択不可
//
//        barChartView.animate(xAxisDuration: 2) // 2秒かけてアニメーション表示
        
        
        
        
        
        
        
        
        
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
