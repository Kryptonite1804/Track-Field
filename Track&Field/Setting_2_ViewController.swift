//
//  Setting_2_ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/08/11.
//

import UIKit

class Setting_2_ViewController: UIViewController {

    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var practicePoint_picture: UIImageView!
    @IBOutlet weak var pain_picture: UIImageView!
    @IBOutlet weak var eatTime_PIcture: UIImageView!
    @IBOutlet weak var sleep_picture: UIImageView!
    @IBOutlet weak var tiredLevel_picture: UIImageView!
    
    @IBOutlet weak var practiceType_textfield: UITextField!
    @IBOutlet weak var practicePoint_textfield: UITextField!
    @IBOutlet weak var pain_textfield: UITextField!
    @IBOutlet weak var eatTime_textfield: UITextField!
    @IBOutlet weak var sleepStart_textfield: UITextField!
    @IBOutlet weak var sleepEnd_textfield: UITextField!
    @IBOutlet weak var tiredLevel_textfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        装飾
        let design = [practiceType_picture,practicePoint_picture,pain_picture,eatTime_PIcture,sleep_picture,tiredLevel_picture]
        for n in 0...design.count-1 {
            let designNum = design[n]
            designNum?.layer.cornerRadius = 20
            designNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            designNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            designNum?.layer.shadowOpacity = 0.25  //影の濃さ
            designNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            designNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            designNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            designNum?.layer.borderWidth = 1.0 // 枠線の太さ
        }

        // Do any additional setup after loading the view.
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
