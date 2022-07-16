//
//  Record-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Record_1_ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var practice_comment_record: UITextField!
    @IBOutlet weak var up_distance_record: UITextField!
    @IBOutlet weak var main_mene_record: UITableView!
    @IBOutlet weak var down_distance_record: UITextField!
    @IBOutlet weak var total_distance_record: UITextField!
    
    @IBOutlet weak var team_picture: UIImageView!
    @IBOutlet weak var practiceType_picture: UIImageView!
    @IBOutlet weak var practiceWriting_picture: UIImageView!
    @IBOutlet weak var up_picture: UIImageView!
    @IBOutlet weak var down_picture: UIImageView!
    @IBOutlet weak var total_picture: UIImageView!
    
    
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var practiceTypeButton: UIButton!
    @IBOutlet weak var upTimeButton: UIButton!
    @IBOutlet weak var downTimeButton: UIButton!

    
    var aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let body_Array = [["チーム","team"],["練習タイプ","practiceType"],["アップの時間","upTime"],["ダウンの時間","downTime"]]
        let team_Array = ["A","B","C","D","その他"]
        let practiceType_Array = ["jog","LSD","ペースラン","ビルドアップ","ショートインターバル","ロングインターバル","変化走","刺激","調整","筋トレ","その他"]
        let upTime_Array = ["0:00","5:00","8:00","10:00","15:00","20:00","25:00","30:00","45:00","50:00","55:00","60:00"]
        let downTime_Array = ["0:00","5:00","8:00","10:00","15:00","20:00","25:00","30:00","45:00","50:00","55:00","60:00"]
        
        
        var detail_Array = [String]()
        for m in 0 ... body_Array.count - 1 {
            let bodyJP_String = body_Array[m][0]
            let bodyEN_String = body_Array[m][1]
            
            if m == 0 {
                aboutButton = teamButton
                detail_Array = team_Array
            } else if m == 1 {
                aboutButton = practiceTypeButton
                detail_Array = practiceType_Array
            }else if m == 2 {
                aboutButton = upTimeButton
                detail_Array = upTime_Array
            }else if m == 3 {
                aboutButton = downTimeButton
                detail_Array = downTime_Array
            }
            
            aboutButton.setTitle(bodyJP_String, for: .normal)
            
            var action_Array = [UIMenuElement]()
            
            for n in 0...detail_Array.count - 1 {
                
                let detail_String = detail_Array[n] //excerciseType_Arrayからひとつ取り出し ex."JOG"
                
                let action = UIAction(title: "\(detail_String)", image: UIImage(systemName: "pencil"), handler: { _ in //タイトル設定
                    print("\(bodyEN_String): \(detail_String)") //何が選択されたか表示
                    self.aboutButton.setTitle("\(detail_String)", for: .normal) //選択されたものをButtonのTitleに
                })
                
                action_Array.append(action)  //上記一連の動作を設定
                
            }
            
                let items = UIMenu(options: .displayInline, children: action_Array) //ここでリストの全ボタンを配置
            aboutButton.menu = UIMenu(title: "\(bodyJP_String)を選択", children: [items]) //リスト最上部に出てくる小さくて薄い文字
            aboutButton.showsMenuAsPrimaryAction = true //アニメーションさせる
            
        }
        
         */
         
        let recordsub = [team_picture,placefeild_picture,practiceWriting_picture,up_picture,down_picture,total_picture]
        let recordsubCount = recordsub.count
        for n in 0...recordsubCount-1 {
            let recordsubNum = recordsub[n]
            team_picture.layer.cornerRadius = 5
            team_picture.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)//塗り潰し
            team_picture.layer.shadowColor = UIColor.black.cgColor //　影の色
            team_picture.layer.shadowOpacity = 0.25  //影の濃さ
            team_picture.layer.shadowRadius = 4.0 // 影のぼかし量
            team_picture.layer.shadowOffset = CGSize(width: 3.0, height: 3.0) // 影の方向
            team_picture.layer.borderColor = UIColor(red: 174/255, green: 55/255, blue: 247/255, alpha: 0.75).cgColor  // 枠線の色
            team_picture.layer.borderWidth = 1.0 // 枠線の太さ
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func teamtype_record() {
        aboutButton = teamButton
    }
    
    @IBAction func practictype_record() {
        aboutButton = practiceTypeButton
    }
    
    @IBAction func up_time_record() {
        aboutButton = upTimeButton
    }
    
    @IBAction func main_mene_add() {
    }
    
    @IBAction func down_time_record() {
        aboutButton = downTimeButton
    }
    
    @IBAction func complete() {
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
