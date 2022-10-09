//
//  History-3-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

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
        
//        let painDetail = [painPlace_picture,painStage_picture,painWriting_picture]
//        for n in 0...painDetail.count-1 {
//            let painDetailNum = painDetail[n]
//            painDetailNum?.layer.cornerRadius = 5
//            painDetailNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
//            painDetailNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
//            painDetailNum?.layer.shadowOpacity = 0.25  //影の濃さ
//            painDetailNum?.layer.shadowRadius = 4.0 // 影のぼかし量
//            painDetailNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
//            painDetailNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
//            painDetailNum?.layer.borderWidth = 1.0 // 枠線の太さ
//        }

        let painBase = selectedRunningData4["pain"] as! [String:Any]
        
        let painLevel = painBase["painLebel"] as! String
        pain_number.text = painLevel
        let painLevel2:Float = Float(painLevel)!
        pain_slider.value = painLevel2
        
//        pain_slider.isEnabled = false
//        これをやるとsliderの色付き部分が薄い色になってしまう。
//        代わりに上に透明のLabelが貼ってあるため、既に編集不可になっている。
        
        let painWriting = painBase["painWriting"] as! String
        today_detail.text = painWriting
        
        
        frontRightArm.transform = CGAffineTransform(rotationAngle: .pi/20)
        frontLeftArm.transform = CGAffineTransform(rotationAngle: -.pi/20)
        backRightShould.transform = CGAffineTransform(rotationAngle: .pi/15)
        backLeftShould.transform = CGAffineTransform(rotationAngle: -.pi/15)
        frontRightInAbove.transform = CGAffineTransform(rotationAngle: .pi/36)
        frontLeftInAbove.transform = CGAffineTransform(rotationAngle: -.pi/36)
        frontRightInBelow.transform = CGAffineTransform(rotationAngle: .pi/36)
        frontLeftInBelow.transform = CGAffineTransform(rotationAngle: -.pi/36)
        RightOutFoot.transform = CGAffineTransform(rotationAngle: .pi/20)
        RightInFoot.transform = CGAffineTransform(rotationAngle: .pi/36)
        LeftOutFoot.transform = CGAffineTransform(rotationAngle: -.pi/20)
        LeftInFoot.transform = CGAffineTransform(rotationAngle: -.pi/36)
        
        
        //痛み詳細初期設定
        let painLabel = [frontRightOutAbove,frontLeftOutAbove,frontRightInAbove,frontLeftInAbove,frontRightOutBelow,frontLeftOutBelow,frontRightInBelow,frontLeftInBelow,RightOutFoot,LeftOutFoot,RightInFoot,LeftInFoot,backLeftAbove,backRightAbove,backLeftBelow,backRightBelow,LeftKakato,RightKakato,LeftToe,RightToe,frontRightShould,frontLeftShould,frontRightArm,frontLeftArm,RightRoot,LeftRoot,Stomach,RightChest,LeftChest,RightHenaka,LeftHenaka,Neck,Waist,RightScapula,LeftScapula,RightElbow,LeftElbow,backRightShould,backLeftShould]
        for n in 0...painLabel.count - 1 {
            let painLabelNum = painLabel[n]
            painLabelNum?.layer.cornerRadius = 11
            painLabelNum?.clipsToBounds = true
            let rgba = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            painLabelNum?.textColor = rgba
            painLabelNum?.text = ""
            painLabelNum?.backgroundColor = UIColor.clear
        }
        
        let pain2Label = [frontRightNee,frontLeftNee,backLeftNee,backRightNee]
        for m in 0...pain2Label.count - 1 {
            let painLabelNum = pain2Label[m]
            painLabelNum?.layer.cornerRadius = 8
            painLabelNum?.clipsToBounds = true
            let rgba = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            painLabelNum?.textColor = rgba
            painLabelNum?.text = ""
            painLabelNum?.backgroundColor = UIColor.clear
        }
        
        
        
        
        let painPlace = painBase["painPlace"] as! [String:String]
        
        for l in 1...painPlace.count {
            
            let dictionaryKey = "pain_button\(l)"
            
            let dictionaryValue = painPlace[dictionaryKey]
            
            if dictionaryValue == "あり" {
             //痛みありのため該当Labelを紫色つけ
                let electedLabel = self.view.viewWithTag(l) as! UILabel
                electedLabel.backgroundColor = UIColor(red: 251/255, green: 19/255, blue: 152/255, alpha: 0.5)
                
            } else if dictionaryValue == "なし" {
            //痛みなしのため該当Labelを透明色に
                let electedLabel = self.view.viewWithTag(l) as! UILabel
                electedLabel.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
                
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        
    let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func pain_slider(_ sender: UISlider) {
        
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
