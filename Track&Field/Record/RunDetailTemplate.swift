//
//  RunDetailTemplate.swift
//  Track&Field
//
//  Created by 山田航輝 on 2023/02/14.
//

class RunDetailTemplate {
    
    var distance: String?
    var time: TimeTemplate! = TimeTemplate.init()
    var pace: TimeTemplate! = TimeTemplate.init() //TimeTemplate.init() と同じ
    
    init(distance: String? = nil, time: TimeTemplate!, pace: TimeTemplate!) {
        self.distance = distance
        self.time = time
        self.pace = pace
    }
    init() {
        
    }
    
    struct IntRefleution {
        var minute: Int
        var second: Int
    }
    
    //タイムの自動反映
    func calculateTime() {
        
        let paceInt = IntRefleution.init(minute: Int((pace.minute)) ?? 0, second: Int((pace.second)) ?? 0)
        let distanceInt = Int(distance ?? "0") ?? 0
        
        let paceTotal = paceInt.minute*60 + paceInt.second  //入力されたペースの秒数値
        let timeTotal: Double = Double(paceTotal * distanceInt / 1000) //計算値 - タイムの秒数合計
        
        let timeInt = IntRefleution.init(minute: Int(timeTotal / 60), second: Int(timeTotal) % 60)
        
        
        var minute0: String = ""
        var second0: String = ""
        
        if timeInt.minute < 10 {
            minute0 = "0"
        }
        
        if timeInt.second < 10 {
            second0 = "0"
        }
        
        time.minute = "\(minute0)\(timeInt.minute)"
        time.second = "\(second0)\(timeInt.second)"
    }
    
    
    
    //距離選択時の計算はこれを使用
    func calculatePace() {
        
        let timeInt = IntRefleution.init(minute: Int((time.minute)!) ?? 0, second: Int((time.second)!) ?? 0)
        let distanceInt = Int(distance ?? "0") ?? 0
        
        let timeTotal = timeInt.minute * 60 + timeInt.second  //入力されたタイムの秒数値
        let paceTotal: Double!
        
        print("timeTotal")
        print(timeTotal)
        print("distanceInt")
        print(distanceInt)
        
        if distanceInt == 0 {
            paceTotal = 0
        } else {
            paceTotal = Double(timeTotal * 1000 / distanceInt ) //計算値 - ペースの秒数合計 MARK: *1000を先につける！
            print("1000mあたりのpace総数")
            print(paceTotal ?? "unknown")
        }
        
        let paceInt = IntRefleution.init(minute: Int(paceTotal / 60), second: Int(paceTotal) % 60)
        
        var minute0: String = ""
        var second0: String = ""
        
        if paceInt.minute < 10 {
            minute0 = "0"
        }
        
        if paceInt.second < 10 {
            second0 = "0"
        }
        
        pace.minute = "\(minute0)\(paceInt.minute)"
        pace.second = "\(second0)\(paceInt.second)"
        
    }
    
}
