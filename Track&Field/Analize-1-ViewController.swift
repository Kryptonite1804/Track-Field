//
//  Analize-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Analize_1_ViewController: UIViewController {
    
    @IBOutlet weak var graphDate_Label: UILabel!
    @IBOutlet weak var graphTitle_Label: UILabel!
    
    @IBOutlet weak var graphDate_picture: UIImageView!
    @IBOutlet weak var graphTitle_picture: UIImageView!
    
    var element1_String: String = ""
    var element2_String: String = ""
    
    var element1_Kind_String: String = ""
    var element2_Kind_String: String = ""
    
    var startDate_String: String = ""
    var endDate_String: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        graphDate_picture.layer.cornerRadius = 15
        graphDate_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
        graphDate_picture.layer.borderWidth = 1.0 // 枠線の太さ
        
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
        
        
        
        element1_String = UserDefaults.standard.string(forKey: "element1_value") ?? ""
        element2_String = UserDefaults.standard.string(forKey: "element2_value") ?? ""
        element1_Kind_String = UserDefaults.standard.string(forKey: "element1_kind") ?? ""
        element2_Kind_String = UserDefaults.standard.string(forKey: "element2_kind") ?? ""
        startDate_String = UserDefaults.standard.string(forKey: "startDate_graph") ?? ""
        endDate_String = UserDefaults.standard.string(forKey: "endDate_graph") ?? ""
       
        graphDate_Label.text = "\(startDate_String) ~ \(endDate_String)"
        
        
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
