//
//  History-3-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class History_3_ViewController: UIViewController {

    @IBOutlet weak var pain_number: UILabel!
    @IBOutlet weak var today_detail: UITextView!
    @IBOutlet weak var pain_slider: UISlider!
    
    @IBOutlet weak var frontRightOutAbove: UILabel!
    @IBOutlet weak var frontLeftOutAbove: UILabel!
    @IBOutlet weak var frontRightInAbove: UILabel!
    @IBOutlet weak var frontLeftInAbove: UILabel!
    @IBOutlet weak var forntRightNee: UILabel!
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
    
    
    @IBOutlet weak var painPlace_picture: UIImageView!
    @IBOutlet weak var painStage_picture: UIImageView!
    @IBOutlet weak var painWriting_picture: UIImageView!
    
    var selectedRunningData4 :[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let painDetail = [painPlace_picture,painStage_picture,painWriting_picture]
        for n in 0...painDetail.count-1 {
            let painDetailNum = painDetail[n]
            painDetailNum?.layer.cornerRadius = 5
            painDetailNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            painDetailNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            painDetailNum?.layer.shadowOpacity = 0.25  //影の濃さ
            painDetailNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            painDetailNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            painDetailNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            painDetailNum?.layer.borderWidth = 1.0 // 枠線の太さ
        }

        let painLevel = selectedRunningData4["pain_Level"] as! String
        pain_number.text = painLevel
        let painLevel2:Float = Float(painLevel)!
        pain_slider.value = painLevel2
        let painWriting = selectedRunningData4["pain_Writing"] as! String
        today_detail.text = painWriting
        
        frontRightInAbove.transform = CGAffineTransform(rotationAngle: .pi/36)
        frontLeftInAbove.transform = CGAffineTransform(rotationAngle: -.pi/36)
        frontRightInBelow.transform = CGAffineTransform(rotationAngle: .pi/36)
        frontLeftInBelow.transform = CGAffineTransform(rotationAngle: -.pi/36)
        RightOutFoot.transform = CGAffineTransform(rotationAngle: .pi/20)
        RightInFoot.transform = CGAffineTransform(rotationAngle: .pi/36)
        LeftOutFoot.transform = CGAffineTransform(rotationAngle: -.pi/20)
        LeftInFoot.transform = CGAffineTransform(rotationAngle: -.pi/36)
        
        let painLabel = [backLeftAbove,backRightAbove,backLeftNee,backRightNee,backLeftBelow,backRightBelow,LeftKakato,RightKakato,LeftToe,RightToe]
        for n in 0...painLabel.count{
            let painLabelNum = painLabel[n]
            painLabelNum?.layer.cornerRadius = 30
            painLabelNum?.clipsToBounds = true
            let rgba = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
            painLabelNum?.textColor = rgba
        }
        
        // Do any additional setup after loading the view.
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
