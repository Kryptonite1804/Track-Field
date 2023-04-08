//
//  BaseData.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/01/28.
//

import UIKit


class BaseData {
    
    var mealTime: String?
    var placeType: String?
    var practicePoint: String?
    var sleepStart: String?
    var sleepEnd: String?
    var tiredLevel: String?
    var writing: String?
    var yobi: String?
    var pain: [String: Any]?
    
    //書かなくても良い・同じ内容が実行される
//    init() {
//    }
    
    
    
    //一斉設定したい場合はコレ
//    init(mealTime: String? = nil, placeType: String? = nil, practicePoint: String? = nil,
//         sleepStart: String? = nil, sleepEnd: String? = nil, tiredLevel: String? = nil,
//         writing: String? = nil, yobi: String? = nil, pain: [String: Any]? = nil) {
//        
//        self.mealTime = mealTime
//        self.placeType = placeType
//        self.practicePoint = practicePoint
//        self.sleepStart = sleepStart
//        self.sleepEnd = sleepEnd
//        self.tiredLevel = tiredLevel
//        self.writing = writing
//        self.yobi = yobi
//        self.pain = pain
//    }
    
}
