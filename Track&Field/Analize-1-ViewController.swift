//
//  Analize-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Analize_1_ViewController: UIViewController {
    
    @IBOutlet weak var grapf_kind: UILabel!
    @IBOutlet weak var graph_titile: UILabel!
    
    @IBOutlet weak var graphKind_picture: UIImageView!
    @IBOutlet weak var graphTitle_picture: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        graphKind_picture.layer.cornerRadius = 20
        graphKind_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        graphKind_picture.layer.borderWidth = 1.0 // 枠線の太さ
        
        graphTitle_picture.layer.cornerRadius = 20
        graphTitle_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        graphTitle_picture.layer.borderWidth = 2.0 // 枠線の太さ
        graphTitle_picture.layer.shadowColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.5).cgColor //　影の色
        graphTitle_picture.layer.shadowOpacity = 0.5  //影の濃さ
        graphTitle_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphTitle_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        graphTitle_picture.layer.shadowColor = UIColor.white.cgColor //　影の色
        graphTitle_picture.layer.shadowOpacity = 1.0  //影の濃さ
        graphTitle_picture.layer.shadowRadius = 2 // 影のぼかし量
        graphTitle_picture.layer.shadowOffset = CGSize(width: -2.0, height: -2.0) // 影の方向
        
        // Do any additional setup after loading the view.
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
