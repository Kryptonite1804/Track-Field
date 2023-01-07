//
//  timerViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/11/02.
//

import UIKit

class timerViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var count: Float = 0.0
    var timer: Timer = Timer()
    var rank: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func start() {
        
        if !timer.isValid {  //"!"で"~でないとき"という意味
            
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(self.up),
                                         userInfo: nil,
                                         repeats: true)
            
        }
        
    }
    
    @IBAction func stop() {
        
        if timer.isValid {
            timer.invalidate()
        }
        
    }
    
    
    
    
    @objc func up() {
        count = count + 1.0
        
        var intCount = Int(count)
        var minute: Int = 0
        var second: Int = 0
        var minute_S: String = ""
        var second_S: String = ""
        
        if intCount < 60 {
            
            second = intCount
            
        } else {
            
            minute = intCount/60
            second = intCount%60
            
        }
        
        
        
        if second % 4 == 0 || second % 4 == 1 || second % 4 == 2 {
            //奇数の時
            
            if minute < 10 {
                minute_S = "0\(minute)"
            } else {
                minute_S = "\(minute)"
            }
            
            if second < 10 {
                second_S = "0\(second)"
            } else {
                second_S = "\(second)"
            }
            
            label.text = "\(minute_S):\(second_S)"
            
        } else {
            //偶数の時
            label.text = "\(rank)位"
        }
        
    }
    
    @IBAction func reset() {
        if timer.isValid {
            timer.invalidate()
        }
        count = 0.0
        
        label.text = "00:00"
    }
    
    @IBAction func plus() {
        rank += 1
    }
    
    @IBAction func minus() {
        rank -= 1
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
