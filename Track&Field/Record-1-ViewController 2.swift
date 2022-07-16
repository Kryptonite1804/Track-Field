//
//  Record-1-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Record_1_ViewController: UIViewController {
    
    @IBOutlet weak var practice_comment_record: UITextField!
    @IBOutlet weak var up_distance_record: UITextField!
    @IBOutlet weak var main_mene_record: UITableView!
    @IBOutlet weak var down_distance_record: UITextField!
    @IBOutlet weak var total_distance_record: UITextField!
    
    @IBOutlet weak var teamButton: UIButton!
    @IBOutlet weak var practiceTypeButton: UIButton!
    @IBOutlet weak var upTimeButton: UIButton!
    @IBOutlet weak var downTimeButton: UIButton!

    
    var aboutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
