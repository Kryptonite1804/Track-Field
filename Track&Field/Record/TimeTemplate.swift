//
//  TimeTemplate.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/02/14.
//

class TimeTemplate {
    
    var hour: String?
    var minute: String! = ""
    var second: String! = ""
    
    //hour, minute, second を一斉設定したい時はコレ
    init(hour: String? = nil, minute: String!, second: String!) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
//    TimeTemplate()で呼び出した場合に呼ばれる
//    init() {
//        //何も指定しないバージョン
//        hour = nil
//        minute = ""
//        second = ""
//        　　　　　　が代入される
//    }
    
    init() {
        self.hour = "00"
        self.minute = "00"
        self.second = "00"
    }
    
}
