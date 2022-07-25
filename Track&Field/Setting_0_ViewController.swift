//
//  Setting_0_ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/23.
//

import UIKit

class Setting_0_ViewController: UIViewController {
    
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var groupMumber_picture: UIImageView!
    @IBOutlet weak var logout_picture: UIImageView!
    @IBOutlet weak var accountDelete_picture: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picture = [profile_picture,groupMumber_picture,logout_picture,accountDelete_picture]
        for n in 0...picture.count - 1 {
            let pictureNum = picture[n]
            pictureNum?.layer.cornerRadius = 5
            pictureNum?.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            pictureNum?.layer.shadowColor = UIColor.black.cgColor //　影の色
            pictureNum?.layer.shadowOpacity = 0.25  //影の濃さ
            pictureNum?.layer.shadowRadius = 4.0 // 影のぼかし量
            pictureNum?.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            pictureNum?.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            pictureNum?.layer.borderWidth = 1.0 // 枠線の太さ
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
