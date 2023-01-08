//
//  Analize-0-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/19.
//

import UIKit
import SafariServices

class Analize_0_ViewController: UIViewController, SFSafariViewControllerDelegate/*, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource*/ {
    
    @IBOutlet weak var startday_check: UIImageView!
    @IBOutlet weak var endday_check: UIImageView!
    @IBOutlet weak var graph_key1_check: UIImageView!
    @IBOutlet weak var graph_key2_check: UIImageView!
    
    @IBOutlet weak var startday_picture: UIImageView!
    @IBOutlet weak var endday_picture: UIImageView!
    @IBOutlet weak var graphKey1_picture: UIImageView!
    @IBOutlet weak var graphKey2_picture: UIImageView!
    @IBOutlet weak var makegrah_picture: UIImageView!
    
    @IBOutlet var startDate_DatePicker: UIDatePicker!
    @IBOutlet var endDate_DatePicker: UIDatePicker!
    
    @IBOutlet weak var element1_Button: UIButton!
    @IBOutlet weak var element2_Button: UIButton!
    
    @IBOutlet weak var element1_Label: UILabel!
    @IBOutlet weak var element2_Label: UILabel!
    
    @IBOutlet weak var element1_None_Label: UILabel!
    @IBOutlet weak var element2_None_Label: UILabel!
    
    
    
    var element1_String: String = ""
    var element2_String: String = ""
    
    var element1_Kind_String: String = ""
    var element2_Kind_String: String = ""
    
    
    
    //    var element1_Array = ["曜日","練習場所タイプ","練習評価","痛みの有無","痛みの度合い","食事の回数","睡眠時間","疲労度","チーム","練習タイプ","アップの距離","ダウンの距離","アップのタイム","ダウンのタイム","トータル距離"]
    //    var element2_Array = ["曜日","練習場所タイプ","練習評価","痛みの有無","痛みの度合い","食事の回数","睡眠時間","疲労度","チーム","練習タイプ","アップの距離","ダウンの距離","アップのタイム","ダウンのタイム","トータル距離"]
    //
    //    var error_Array = ["エラー"]
    
    let date_Formatter = DateFormatter()  //DP
    
    var startDate_String: String = ""
    var endDate_String: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //DP
        date_Formatter.dateFormat = "yyyy年MM月dd日"
        
        var datePickerArray = [startDate_DatePicker,endDate_DatePicker]
        for dpcount in 0...datePickerArray.count-1 {
            let dp = datePickerArray[dpcount]
            dp?.datePickerMode = UIDatePicker.Mode.date
            dp?.timeZone = NSTimeZone.local
            dp?.locale = Locale.current
            dp?.endEditing(true)
            dp?.maximumDate = NSDate() as Date
        }
        
        UserDefaults.standard.set("", forKey: "element1_value")
        UserDefaults.standard.set("", forKey: "element2_value")
        UserDefaults.standard.set("", forKey: "element1_kind")
        UserDefaults.standard.set("", forKey: "element2_kind")
        
        
        self.graph_key1_check.image = UIImage(systemName: "exclamationmark.circle.fill")
        self.graph_key1_check.tintColor = Asset.subRedColor.color
        //ピンク - "！"
        
        self.graph_key2_check.image = UIImage(systemName: "exclamationmark.circle.fill")
        self.graph_key2_check.tintColor = Asset.subRedColor.color
        //ピンク - "！"
        
        startDate_String = date_Formatter.string(from: Date())
        print("初期値 - 開始日時設定: \(startDate_String)")
        endDate_String = date_Formatter.string(from: Date())
        print("初期値 - 終了日時設定: \(endDate_String)")
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let elementcheck = UserDefaults.standard.string(forKey: "elementCheck") ?? ""
        
        element1_String = UserDefaults.standard.string(forKey: "element1_value") ?? ""
        element2_String = UserDefaults.standard.string(forKey: "element2_value") ?? ""
        element1_Kind_String = UserDefaults.standard.string(forKey: "element1_kind") ?? ""
        element2_Kind_String = UserDefaults.standard.string(forKey: "element2_kind") ?? ""
        
        print("elementcheck",elementcheck)
        print("element1_String",element1_String)
        print("element2_String",element2_String)
        print("element1_kind",element1_Kind_String)
        print("element2_kind",element2_Kind_String)
        
        //        if element1_String != "" && element1_String == element2_String {
        //
        //            alert(title: "同じ要素は選べません", message: "要素1と要素2で同じ要素が選択されたようです。\n同じ要素でグラフを作成することはできません。\n違う要素を選択し直してください。")
        //
        //        } else {
        
        if elementcheck == "element1" {
            
            element1_Label.text = element1_String
            
            
            self.graph_key1_check.image = UIImage(systemName: "checkmark.circle.fill")
            self.graph_key1_check.tintColor = .link
            //ブルー - " ✔︎ "
            
            print("通ったよ")
            
        } else if elementcheck == "element2" {
            
            element2_Label.text = element2_String
            
            self.graph_key2_check.image = UIImage(systemName: "checkmark.circle.fill")
            self.graph_key2_check.tintColor = .link
            //ブルー - " ✔︎ "
            
            print("通ったお")
        }
        
        //1
        
        UserDefaults.standard.set("", forKey: "elementCheck")
        //            UserDefaults.standard.set("", forKey: "element1_value")
        //            UserDefaults.standard.set("", forKey: "element2_value")
        //            UserDefaults.standard.set("", forKey: "element1_kind")
        //            UserDefaults.standard.set("", forKey: "element2_kind")
        //        }
        
        if element1_String == "" {
            element1_Label.isHidden = true
            element1_None_Label.isHidden = false
        } else {
            element1_Label.isHidden = false
            element1_None_Label.isHidden = true
        }
        
        if element2_String == "" {
            element2_Label.isHidden = true
            element2_None_Label.isHidden = false
        } else {
            element2_Label.isHidden = false
            element2_None_Label.isHidden = true
        }
    }
    
    
    
    
    
    
    //Alert
    var alertController: UIAlertController!
    
    //Alert
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    
    @IBAction func tap1(_ sender: UIButton) {
        graphKey1_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel1(_ sender: UIButton) {
        graphKey1_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func graph_key1() {
        graphKey1_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        UserDefaults.standard.set("element1", forKey: "elementCheck")
        self.performSegue(withIdentifier: "go-ana-2", sender: self)
    }
    
    @IBAction func tap2(_ sender: UIButton) {
        graphKey2_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel2(_ sender: UIButton) {
        graphKey2_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func graph_key2() {
        graphKey2_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        UserDefaults.standard.set("element2", forKey: "elementCheck")
        self.performSegue(withIdentifier: "go-ana-2", sender: self)
    }
    
    @IBAction func tap3() {
        startday_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel3() {
        startday_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func startDate_DP_Tapped() {
        startday_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        
        startDate_String = date_Formatter.string(from: startDate_DatePicker.date)
        print("開始日時設定: \(startDate_String)")
        
        let startDate_Date = date_Formatter.date(from: startDate_String)
        endDate_DatePicker.minimumDate = startDate_Date
        
    }
    
    
    
    @IBAction func tap4() {
        endday_picture.image = UIImage(named: "w_pushed_long")
    }
    @IBAction func cancel4() {
        endday_picture.image = UIImage(named: "p_rectangle_detail_M_D")
    }
    @IBAction func endDate_DP_Tapped() {
        endday_picture.image = UIImage(named: "p_rectangle_detail_M_D")
        
        endDate_String = date_Formatter.string(from: endDate_DatePicker.date)
        print("終了日時設定: \(endDate_String)")
        
        let endDate_Date = date_Formatter.date(from: endDate_String)
        startDate_DatePicker.maximumDate = endDate_Date
        
    }
    
    
    
    @IBAction func tap5(_ sender: UIButton) {
        makegrah_picture.image = UIImage(named: "p_pushed_m")
    }
    @IBAction func cancel5(_ sender: UIButton) {
        makegrah_picture.image = UIImage(named: "p_rectangle_curbed_M")
    }
    @IBAction func make_graph() {
        makegrah_picture.image = UIImage(named: "p_rectangle_curbed_M")
        //グラフの日付・要素確認
        
        print("startDate_String")
        print(startDate_String)
        print("endDate_String")
        print(endDate_String)
        
        
        
        
        if element1_String == "" {
            
            alert(title: "要素1が選択されていません", message: "要素1を選択し、\nグラフを作成し直してください。")
            
        } else if element2_String == "" {
            
            alert(title: "要素2が選択されていません", message: "要素2を選択し、\nグラフを作成し直してください。")
            
        } else if element1_String == element2_String {
            
            alert(title: "同じ要素は選べません", message: "要素1と要素2で同じ要素が\n選択されているようです。\n同じ要素でグラフを\n作成することはできません。\n異なる要素を選択してください。")
            
        } else if element1_Kind_String == element2_Kind_String && element1_Kind_String == "項目" {
            print("element1_Kind_String == element2_Kind_String && element1_Kind_String == 項目")
            alert(title: "「項目」要素は\n複数選択することはできません", message: "要素1と要素2 両方で「項目」要素が\n選択されているようです。\n「項目」要素を複数選択する\nことはできません。\nどちらか「項目」でない要素を\n選択してください。")
            
        } else if element1_Kind_String == element2_Kind_String && element1_Kind_String == "結果" {
            print("element1_Kind_String == element2_Kind_String && element1_Kind_String == 結果")
            alert(title: "「結果」要素は\n複数選択することはできません", message: "要素1と要素2 両方で「結果」要素が\n選択されているようです。\n「結果」要素を複数選択する\nことはできません。\nどちらか「結果」でない要素を\n選択してください。")
            
        } else {
            
            if (element1_Kind_String == "評価" && element2_Kind_String == "結果") || (element1_Kind_String == "項目" && element2_Kind_String == "結果") || (element1_Kind_String == "項目" && element2_Kind_String == "評価") {
                
                let element1_Alternative = element1_String
                let element1_Kind_Alternative = element1_Kind_String
                
                element1_String = element2_String
                element1_Kind_String = element2_Kind_String
                
                element2_String = element1_Alternative
                element2_Kind_String = element1_Kind_Alternative
                
                
                element1_Label.text = element1_String
                element2_Label.text = element2_String
                
                
            }
            
            
            UserDefaults.standard.set(element1_String, forKey: "element1_value")
            UserDefaults.standard.set(element2_String, forKey: "element2_value")
            UserDefaults.standard.set(element1_Kind_String, forKey: "element1_kind")
            UserDefaults.standard.set(element2_Kind_String, forKey: "element2_kind")
            UserDefaults.standard.set(startDate_String, forKey: "startDate_graph")
            UserDefaults.standard.set(endDate_String, forKey: "endDate_graph")
            
            
            self.performSegue(withIdentifier: "go-ana-1", sender: self)
            
            
        }
        
        
    }
    
    
    
    @IBAction func goForm(_ sender: Any) {
        
        let url = NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfjjuOWVL-csl3YON7hW922PKqrhlT-3u5bHUcQRRtQmU_OtQ/viewform")
        
        if let url = url {
            let safariViewController = SFSafariViewController(url: url as URL)
            safariViewController.delegate = self
            present(safariViewController, animated: true, completion: nil)
        }
        
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
