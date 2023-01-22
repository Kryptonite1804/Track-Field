//
//  History-3-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//
//なし

import UIKit
import SafariServices

class History_3_ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var pain_number: UILabel!
    @IBOutlet weak var today_detail: UITextView!
    @IBOutlet weak var pain_slider: UISlider!
    
    @IBOutlet weak var frontRightOutAbove: UILabel!
    @IBOutlet weak var frontLeftOutAbove: UILabel!
    @IBOutlet weak var frontRightInAbove: UILabel!
    @IBOutlet weak var frontLeftInAbove: UILabel!
    @IBOutlet weak var frontRightNee: UILabel!
    @IBOutlet weak var frontLeftNee: UILabel!
    @IBOutlet weak var frontRightOutBelow: UILabel!
    @IBOutlet weak var frontLeftOutBelow: UILabel!
    @IBOutlet weak var frontRightInBelow: UILabel!
    @IBOutlet weak var frontLeftInBelow: UILabel!
    @IBOutlet weak var RightOutFoot: UILabel!
    @IBOutlet weak var LeftOutFoot: UILabel!
    @IBOutlet weak var RightInFoot: UILabel!
    @IBOutlet weak var LeftInFoot: UILabel!
    
    @IBOutlet weak var backLeftAbove: UILabel!
    @IBOutlet weak var backRightAbove: UILabel!
    @IBOutlet weak var backLeftNee: UILabel!
    @IBOutlet weak var backRightNee: UILabel!
    @IBOutlet weak var backLeftBelow: UILabel!
    @IBOutlet weak var backRightBelow: UILabel!
    @IBOutlet weak var LeftKakato: UILabel!
    @IBOutlet weak var RightKakato: UILabel!
    @IBOutlet weak var LeftToe: UILabel!
    @IBOutlet weak var RightToe: UILabel!
    
    @IBOutlet weak var frontRightShould: UILabel!
    @IBOutlet weak var frontLeftShould: UILabel!
    @IBOutlet weak var frontRightArm: UILabel!
    @IBOutlet weak var frontLeftArm: UILabel!
    @IBOutlet weak var RightRoot: UILabel!
    @IBOutlet weak var LeftRoot: UILabel!
    @IBOutlet weak var Stomach: UILabel!
    @IBOutlet weak var RightChest: UILabel!
    @IBOutlet weak var LeftChest: UILabel!
    @IBOutlet weak var Neck: UILabel!
    @IBOutlet weak var Waist: UILabel!
    @IBOutlet weak var LeftHenaka: UILabel!
    @IBOutlet weak var RightHenaka: UILabel!
    @IBOutlet weak var RightScapula: UILabel!
    @IBOutlet weak var LeftScapula: UILabel!
    @IBOutlet weak var RightElbow: UILabel!
    @IBOutlet weak var LeftElbow: UILabel!
    @IBOutlet weak var backRightShould: UILabel!
    @IBOutlet weak var backLeftShould: UILabel!
    
    
    
    @IBOutlet weak var painPlace_picture: UIImageView!
    @IBOutlet weak var painStage_picture: UIImageView!
    @IBOutlet weak var painWriting_picture: UIImageView!
    
    var selectedRunningData4 :[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let painBase = selectedRunningData4["pain"] as! [String:Any]
        
        let painLevel = painBase["painLebel"] as! String
        pain_number.text = painLevel
        let painLevel2:Float = Float(painLevel)!
        pain_slider.value = painLevel2
        
        //        pain_slider.isEnabled = false
        //        これをやるとsliderの色付き部分が薄い色になってしまう。
        //        代わりに上に透明のLabelが貼ってあるため、既に編集不可になっている。
        
        today_detail.text = painBase["painWriting"] as? String ?? ""
        
        var array0 = [backRightShould,backLeftShould]
        for (ui) in array0 {
            ui?.transform = OtherHost.cgAffineTransform(15)
        }
        
        var array1 = [frontRightArm,frontLeftArm,RightOutFoot,LeftOutFoot]
        for (ui) in array1 {
            ui?.transform = OtherHost.cgAffineTransform(20)
        }
        
        var array2 = [frontRightInAbove,frontLeftInAbove,frontRightInBelow,frontLeftInBelow,RightInFoot,LeftInFoot]
        for (ui) in array2 {
            ui?.transform = OtherHost.cgAffineTransform(36)
        }
        
        //痛み詳細初期設定
        let painLabel = [frontRightOutAbove,frontLeftOutAbove,frontRightInAbove,frontLeftInAbove,frontRightOutBelow,frontLeftOutBelow,frontRightInBelow,frontLeftInBelow,RightOutFoot,LeftOutFoot,RightInFoot,LeftInFoot,backLeftAbove,backRightAbove,backLeftBelow,backRightBelow,LeftKakato,RightKakato,LeftToe,RightToe,frontRightShould,frontLeftShould,frontRightArm,frontLeftArm,RightRoot,LeftRoot,Stomach,RightChest,LeftChest,RightHenaka,LeftHenaka,Neck,Waist,RightScapula,LeftScapula,RightElbow,LeftElbow,backRightShould,backLeftShould]
        for (painLabelNum) in painLabel {
            painLabelNum?.layer.cornerRadius = 11
            painLabelNum?.clipsToBounds = true
            let rgba = Asset.clearColor.color
            painLabelNum?.textColor = rgba
            painLabelNum?.text = ""
            painLabelNum?.backgroundColor = UIColor.clear
        }
        
        let pain2Label = [frontRightNee,frontLeftNee,backLeftNee,backRightNee]
        for (painLabelNum) in pain2Label {
            painLabelNum?.layer.cornerRadius = 8
            painLabelNum?.clipsToBounds = true
            let rgba = Asset.clearColor.color
            painLabelNum?.textColor = rgba
            painLabelNum?.text = ""
            painLabelNum?.backgroundColor = UIColor.clear
        }
        
        let painPlace = painBase["painPlace"] as! [String:String]
        for l in 1...painPlace.count {
            let dictionaryValue = painPlace["pain_button\(l)"] ?? "なし"
            
            if dictionaryValue == "あり" {
                //痛みありのため該当Labelを赤色つけ
                let electedLabel = self.view.viewWithTag(l) as! UILabel
                electedLabel.backgroundColor = Asset.painColor.color
                
            } else if dictionaryValue == "なし" {
                //痛みなしのため該当Labelを透明色に
                let electedLabel = self.view.viewWithTag(l) as! UILabel
                electedLabel.backgroundColor = Asset.clearColor.color
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
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
