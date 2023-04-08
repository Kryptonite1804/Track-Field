//
//  File.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/24.
//

import UIKit
import Firebase

class RecordRunningData {
    
    let dateFormatter = DateFormatter()
    
    var empty_Dictionary: Dictionary = ["main":"","sub":"","free":""]
    
    var todayYobi: String = ""
    
    var db = Firestore.firestore()
    
    var returnvalue = false
    
    static let shared = RecordRunningData()
    
    
    func recordData(todayYear:String, todayMonth:String, todayDay:String, toRecordUD:[String: Any]) async throws -> Bool  {
        //Auth - UID取得
        let task = Task {
            do {
                
                returnvalue = false
                
                var runningData_Dictionary = try await FirebaseClient.shared.getPracticeHistory(year: todayYear, month: todayMonth)
                
                let collectionName = "\(todayYear)-\(todayDay)"
                print("runningData_Dictionary: \(runningData_Dictionary)")
                
                //ここで過去分確認・未入力日の分を入力
                let recordedDayCount = runningData_Dictionary.count
                let intDay: Int = Int(todayDay) ?? 0
                
                if recordedDayCount < intDay - 1 {
                    
                    for n in recordedDayCount + 1 ... intDay - 1 {
                        //曜日の生成・適正代入
                        self.dateFormatter.dateFormat = "yyyy/M/d"
                        let applicableDate_DateType = self.dateFormatter.date(from: "\(todayYear)/\(todayMonth)/\(n)")!
                        print(applicableDate_DateType)
                        
                        let today = Date()
                        let today_DateType = self.dateFormatter.date(from: self.dateFormatter.string(from: today))!
                        let elapsedDays = Calendar.current.dateComponents([.day], from: applicableDate_DateType, to: today_DateType).day!
                        
                        self.dateFormatter.dateFormat = "E"
                        todayYobi = dateFormatter.string(from: today)
                        
                        let yobi_Array = ["日","月","火","水","木","金","土"]
                        var standardNumber: Int = 0
                        for k in 0...6 {
                            if todayYobi == yobi_Array[k] {
                                standardNumber = k
                            }
                        }
                        
                        var calculatedNumber = elapsedDays % 7
                        calculatedNumber = standardNumber - calculatedNumber
                        if calculatedNumber < 0 {
                            calculatedNumber = calculatedNumber + 7
                        }
                        
                        let yobi = yobi_Array[calculatedNumber]
                        
                        //曜日の生成・適正代入
                        let dictionary: [String:Any] = ["yobi": yobi]
                        runningData_Dictionary.updateValue(dictionary, forKey: "\(n)")
                        
                    }
                }
                
                //ここから入力された新規データの追加処理
                
                //痛み関連
                var painTF_String = UserDefaults.standard.string(forKey: "painTF") ?? "痛みなし"
                var painPlace_Dictionary = UserDefaults.standard.dictionary(forKey: "painPlace") as? [String:String] ?? ["pain_button1": "なし","pain_button2": "なし","pain_button3": "なし","pain_button4": "なし","pain_button5": "なし","pain_button6": "なし","pain_button7": "なし","pain_button8": "なし","pain_button9": "なし","pain_button10": "なし","pain_button11": "なし","pain_button12": "なし","pain_button13": "なし","pain_button14": "なし","pain_button15": "なし","pain_button216": "なし","pain_button17": "なし","pain_button18": "なし","pain_button19": "なし","pain_button20": "なし","pain_button21": "なし","pain_button22": "なし","pain_button23": "なし","pain_button24": "なし"]
                
                var painLebel_String = UserDefaults.standard.string(forKey: "painLebel") ?? ""
                var painWriting_String = UserDefaults.standard.string(forKey: "painWriting") ?? ""
                
                let painDictonary = ["painTF": painTF_String, "painPlace": painPlace_Dictionary, "painLebel": painLebel_String, "painWriting": painWriting_String] as [String : Any]
                
                
                var team_Dictionary: Dictionary = empty_Dictionary
                var practiceType_Dictionary: Dictionary = empty_Dictionary
                var practiceContent_Dictionary: Dictionary = empty_Dictionary
                
                let upDistance_Dictionary :Dictionary = empty_Dictionary
                var downDistance_Dictionary :Dictionary = empty_Dictionary
                
                let upTime_Dictionary :Dictionary = empty_Dictionary
                let downTime_Dictionary :Dictionary = empty_Dictionary
                
                let runDetail_Dictionary :[String:Any] = [:]
                
                
                //Record-1で入力した内容
                
                let userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
                let groupUid = try await FirebaseClient.shared.getUserData().groupUid ?? ""
                let username = try await FirebaseClient.shared.getUserData().username ?? ""
                
                
                let totalDistance_String = UserDefaults.standard.string(forKey: "totalDistance") ?? ""
                
                for (key, value) in toRecordUD {
                    UserDefaults.standard.set(value, forKey: key)
                }
                
                
                let recordedKayDict = ["team","practiceType","menu","upDistance","downDistance","upTime","downTime","runDetail"]
                var recordedValueDict = [team_Dictionary,practiceType_Dictionary,practiceContent_Dictionary,upDistance_Dictionary,downDistance_Dictionary,upTime_Dictionary,downTime_Dictionary,runDetail_Dictionary]
                for n in 0...recordedKayDict.count-1 {
                    recordedValueDict[n] = UserDefaults.standard.dictionary(forKey: recordedKayDict[n]) ?? self.empty_Dictionary
                }
                
                
                let menuDictionary = ["team": team_Dictionary, "practiceType": practiceType_Dictionary, "menu": practiceContent_Dictionary, "upDistance": upDistance_Dictionary, "downDistance": downDistance_Dictionary, "totalDistance": totalDistance_String, "upTime": upTime_Dictionary, "downTime": downTime_Dictionary, "runDetail": runDetail_Dictionary] as [String : Any]
                
                var dictionary: [String: Any] = [
                    "yobi": todayYobi,
                    "pain": painDictonary,
                    "menuBody": menuDictionary
                ]
                
                dictionary.merge( toRecordUD ){ (_, new) in new }
                
                runningData_Dictionary.updateValue(dictionary, forKey: todayDay)
                
                try? await db.collection("Users").document(userUid).updateData(
                    [collectionName : runningData_Dictionary])
                
                var groupRunningData2_Dictionary = try await FirebaseClient.shared.getTodayData(year: todayYear, month: todayMonth, day: todayDay)
                
                dictionary.updateValue(username, forKey: "username")
                
                groupRunningData2_Dictionary.updateValue(dictionary, forKey: "\(userUid)")
                var groupRunningData_Dictionary = [:]
                groupRunningData_Dictionary.updateValue(groupRunningData2_Dictionary, forKey: "\(todayYear)-\(todayMonth)-\(todayDay)")
                
                try await self.db.collection("Group").document(groupUid).updateData(
                    ["todayData" : groupRunningData_Dictionary])
                
                UserDefaults.standard.set("\(todayYear)/\(todayMonth)/\(todayDay)", forKey: "checkDay22")
                
                returnvalue = true
                
                //ここまで
            }
            catch {
                print(error.localizedDescription)
                returnvalue = false
            }
        }  //Auth
        
        //↓} :全項目入力有無_if文_1つ目閉じ
        
        return returnvalue
    }
    
    
    
}


