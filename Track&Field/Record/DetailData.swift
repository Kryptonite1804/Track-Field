//
//  DetailData.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/28.
//

import Foundation

class DetailDataTemp {
    
    var menu: String?
    var practiceType: String?
    var team: String?
    var upDistance: String! = "0"
    var downDistance: String! = "0"
    var upTime: TimeTemplate! = TimeTemplate() //minute: "00" second: "00"
    var downTime: TimeTemplate! = TimeTemplate() //minute: "00" second: "00"
    var runDetail: [RunDetailTemplate?]? = [RunDetailTemplate.init()] //初期値として一行分代入しておく
    
    //menu, practiceType, teamを一斉設定したい場合使う
    init(menu: String? = nil, practiceType: String? = nil, team: String? = nil) {
        self.menu = menu
        self.practiceType = practiceType
        self.team = team
    }
    
    
    func nilCheck() -> String! {
        let dict = ["メニュー内容": menu, "練習タイプ": practiceType, "チーム": team, "アップの距離": upDistance, "ダウンの距離": downDistance, "アップのタイム(分)": upTime.minute, "アップのタイム(秒)": upTime.second, "ダウンのタイム(分)": downTime.minute, "ダウンのタイム(秒)": downTime.second]
        
        var nilCheckVar: String! = nil
        
        if (menu == nil || menu == "") && (practiceType == nil || practiceType == "") && (team == nil || team == "") {
            
            nilCheckVar = "none"
            //未入力SCのため飛ばし
            
        } else {
            
            for (key, value) in dict {
                if nilCheckVar == nil || nilCheckVar == "none" {
                    if value == nil || value == "" {
                        nilCheckVar = key
                    }
                }
            }
            
            for count in 0...(runDetail?.count ?? 1) - 1 {
                if nilCheckVar == nil || nilCheckVar == "none" {
                    let oneRunDetail = runDetail?[count]
                    let array = [oneRunDetail?.time.minute, oneRunDetail?.time.second, oneRunDetail?.pace.minute, oneRunDetail?.pace.second, oneRunDetail?.distance]
                    
                    for (value) in array {
                        if value == nil || value == "" {
                            nilCheckVar = "メニュー詳細"
                        }
                    }
                    
                }
            }
            
        }
        
        return nilCheckVar
    }
    
    
    
//    struct DetailData: Codable {
//        let menu: String
//        let practiceType: String
//        let team: String
//        let upDistance: String
//        let downDistance: String
//        let upTime: TimeTemplate
//        let downTime: TimeTemplate
//        let runDetail: [RunDetailTemplate]
//    }
//
//    static func saveUD(data: DetailData, key: String) {
//
//        guard let data = try? JSONEncoder().encode(data) else { return }
//        UserDefaults.standard.set(data, forKey: key)
//        print("保存済")
//    }
    
    
    
}

