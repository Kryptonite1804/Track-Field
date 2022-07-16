//
//  Analize-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit

class Analize_0_ViewController: UIViewController {

    @IBOutlet weak var startday_check: UIImageView!
    @IBOutlet weak var endday_check: UIImageView!
    @IBOutlet weak var graph_key1_check: UIImageView!
    @IBOutlet weak var graph_key2_check: UIImageView!
    
    @IBOutlet weak var startday_picture: UIImageView!
    @IBOutlet weak var endday_picture: UIImageView!
    @IBOutlet weak var graphKey1_picture: UIImageView!
    @IBOutlet weak var graphKey2_picture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startday_picture.layer.cornerRadius = 20
        startday_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        startday_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        startday_picture.layer.shadowOpacity = 0.25  //影の濃さ
        startday_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        startday_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        endday_picture.layer.cornerRadius = 20
        endday_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        endday_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        endday_picture.layer.shadowOpacity = 0.25  //影の濃さ
        endday_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        endday_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        graphKey1_picture.layer.cornerRadius = 20
        graphKey1_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        graphKey1_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        graphKey1_picture.layer.shadowOpacity = 0.25  //影の濃さ
        graphKey1_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphKey1_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        graphKey2_picture.layer.cornerRadius = 20
        graphKey2_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
        graphKey2_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
        graphKey2_picture.layer.shadowOpacity = 0.25  //影の濃さ
        graphKey2_picture.layer.shadowRadius = 4.0 // 影のぼかし量
        graphKey2_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func graph_key1() {
    }
    
    @IBAction func graph_key2() {
    }
    
    @IBAction func startay() {
    }
    
    @IBAction func endday() {
    }
    
    @IBAction func make_graph() {
        //グラフの日付・要素確認
        
        self.performSegue(withIdentifier: "go-ana_1", sender: self)
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
