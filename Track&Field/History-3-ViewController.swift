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
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pain_slider(_ sender: UISlider) {
        
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
