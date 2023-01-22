//
//  Record-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit
import SafariServices

class Record_2_ViewController: UIViewController,UITextViewDelegate, SFSafariViewControllerDelegate {

    @IBOutlet weak var pain_writing: UITextView!
    
    @IBOutlet weak var painPlace_picture: UIImageView!
    @IBOutlet weak var painStage_picture: UIImageView!
    @IBOutlet weak var painWriting_picture: UIImageView!
    
    @IBOutlet weak var painLevel: UILabel!
    
    
    @IBOutlet weak var scrollViewBottomConstraints: NSLayoutConstraint!  //scrollview_キーボード_ずらす
    
    @IBOutlet weak var frontRightOutAbove: UIButton!
    @IBOutlet weak var frontKLeftOutAbove: UIButton!
    @IBOutlet weak var frontRightInAbove: UIButton!
    @IBOutlet weak var frontLeftInAbove: UIButton!
    @IBOutlet weak var frontRightNee: UIButton!
    @IBOutlet weak var frontLeftNee: UIButton!
    @IBOutlet weak var frontRightOutBelow: UIButton!
    @IBOutlet weak var frontLeftOutBelow: UIButton!
    @IBOutlet weak var frontRightInBelow: UIButton!
    @IBOutlet weak var frontLeftInBelow: UIButton!
    @IBOutlet weak var RightOutFoot: UIButton!
    @IBOutlet weak var LeftOutFoot: UIButton!
    @IBOutlet weak var RightInFoot: UIButton!
    @IBOutlet weak var LeftInFoot: UIButton!
  
    @IBOutlet weak var backLeftAbove: UIButton!
    @IBOutlet weak var backRightAbove: UIButton!
    @IBOutlet weak var backLeftNee: UIButton!
    @IBOutlet weak var backRightNee: UIButton!
    @IBOutlet weak var backLeftBelow: UIButton!
    @IBOutlet weak var backRightBelow: UIButton!
    @IBOutlet weak var LeftKakato: UIButton!
    @IBOutlet weak var RightKakato: UIButton!
    @IBOutlet weak var LeftToe: UIButton!
    @IBOutlet weak var RightToe: UIButton!
    
    @IBOutlet weak var frontRightShould: UIButton!
    @IBOutlet weak var frontLeftShould: UIButton!
    @IBOutlet weak var frontRightArm: UIButton!
    @IBOutlet weak var frontLeftArm: UIButton!
    @IBOutlet weak var RightRoot: UIButton!
    @IBOutlet weak var LeftRoot: UIButton!
    @IBOutlet weak var Stomach: UIButton!
    @IBOutlet weak var RightChest: UIButton!
    @IBOutlet weak var LeftChest: UIButton!
    @IBOutlet weak var Neck: UIButton!
    @IBOutlet weak var Waist: UIButton!
    @IBOutlet weak var LeftHenaka: UIButton!
    @IBOutlet weak var RightHenaka: UIButton!
    @IBOutlet weak var RightScapula: UIButton!
    @IBOutlet weak var LeftScapula: UIButton!
    @IBOutlet weak var RightElbow: UIButton!
    @IBOutlet weak var LeftElbow: UIButton!
    @IBOutlet weak var backRightShould: UIButton!
    @IBOutlet weak var backLeftShould: UIButton!
        
    
    var painPlace_Dictionary = ["pain_button1": "なし","pain_button2": "なし","pain_button3": "なし","pain_button4": "なし","pain_button5": "なし","pain_button6": "なし","pain_button7": "なし","pain_button8": "なし","pain_button9": "なし","pain_button10": "なし","pain_button11": "なし","pain_button12": "なし","pain_button13": "なし","pain_button14": "なし","pain_button15": "なし","pain_button16": "なし","pain_button17": "なし","pain_button18": "なし","pain_button19": "なし","pain_button20": "なし","pain_button21": "なし","pain_button22": "なし","pain_button23": "なし","pain_button24": "なし","pain_button25": "なし","pain_button26": "なし","pain_button27": "なし","pain_button28": "なし","pain_button29": "なし","pain_button30": "なし","pain_button31": "なし","pain_button32": "なし","pain_button33": "なし","pain_button34": "なし","pain_button35": "なし","pain_button36": "なし","pain_button37": "なし","pain_button38": "なし","pain_button39": "なし","pain_button40": "なし","pain_button41": "なし","pain_button42": "なし","pain_button43": "なし"]
    var painLebel_String = ""
    var painWriting_string = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TV
        let costombar = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.size.width), height: 40))
        costombar.backgroundColor = UIColor.secondarySystemBackground
        let commitBtn = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width)-50, y: 0, width: 55, height: 40))
        commitBtn.setTitle("完了", for: .normal)
        commitBtn.setTitleColor(UIColor.link, for: .normal)
        commitBtn.addTarget(self, action: #selector(Record_2_ViewController.onClickCommitButton), for: .touchUpInside)
        costombar.addSubview(commitBtn)
        pain_writing.inputAccessoryView = costombar
        pain_writing.keyboardType = .default
        pain_writing.returnKeyType = .default
        pain_writing.delegate = self
        
        //scrollview_キーボード_ずらす
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        //scrollview_キーボード_ずらす
        
        let painButtonAll = [frontRightOutAbove,frontKLeftOutAbove,frontRightInAbove,frontLeftInAbove,frontRightOutBelow,frontLeftOutBelow,frontRightInBelow,frontLeftInBelow,RightOutFoot,LeftOutFoot,RightInFoot,LeftInFoot,backLeftAbove,backRightAbove,backLeftBelow,backRightBelow,LeftKakato,RightKakato,LeftToe,RightToe,frontRightShould,frontLeftShould,frontRightArm,frontLeftArm,RightRoot,LeftRoot,Stomach,RightChest,LeftChest,RightHenaka,LeftHenaka,Neck,Waist,RightScapula,LeftScapula,RightElbow,LeftElbow,backRightShould,backLeftShould]
        for (painButtonAllNum) in painButtonAll {
            painButtonAllNum?.layer.cornerRadius = 11
            painButtonAllNum?.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
            painButtonAllNum?.layer.borderWidth = 1.0 // 枠線の太さ
            painButtonAllNum?.setTitle("", for: .normal)
        }
        
        let painNeeButton = [frontRightNee,frontLeftNee,backLeftNee,backRightNee]
        for (painNeeButtonNum) in painNeeButton {
            painNeeButtonNum?.layer.cornerRadius = 8
            painNeeButtonNum?.layer.borderColor = Asset.lineColor.color.cgColor  // 枠線の色
            painNeeButtonNum?.layer.borderWidth = 1.0 // 枠線の太さ
            painNeeButtonNum?.setTitle("", for: .normal)
        }
        
        var array0 = [backRightShould,backLeftShould]
        for (ui) in array0 {
            ui?.transform = OtherHost.cgAffineTransform(15)
        }
        
        var array1 = [frontRightArm,frontLeftArm,RightOutFoot,LeftOutFoot]
        for (ui) in array1 {
            ui?.transform = OtherHost.cgAffineTransform(20)
        }
        
        var array2 = [frontRightInAbove,frontLeftInAbove,frontRightInBelow,frontLeftInBelow,RightInFoot,LeftInFoot]
        for (ui) in array2 {
            ui?.transform = OtherHost.cgAffineTransform(36)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    //TV  //TVの「完了」Buttonが押された際の処理
    @objc func onClickCommitButton(sender: UIButton) {
        if(pain_writing.isFirstResponder) {
            pain_writing.resignFirstResponder()
            painWriting_string = pain_writing.text
            print("writingText:\(painWriting_string)")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.painWriting_string = self.pain_writing.text!
            print("writingText: \(self.painWriting_string)")
        }
        return true
    }
    
    //scrollview_キーボード_ずらす_ここから
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        print("キーボード表示")
        
        //キーボードのサイズ
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              //キーボードのアニメーション時間
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              //キーボードのアニメーション曲線
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              //Outletで結び付けたScrollViewのBottom制約
              let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }
        
        //キーボードの高さ
        let keyboardHeight = keyboardFrame.height
        //Bottom制約再設定
        scrollViewBottomConstraint.constant = keyboardHeight - 93
        
        //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        print("キーボード非表示")
        
        //キーボードのアニメーション時間
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              //キーボードのアニメーション曲線
              let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              //Outletで結び付けたScrollViewのBottom制約
              let scrollViewBottomConstraint = self.scrollViewBottomConstraints else { return }
        
        //画面いっぱいになるのでBottomのマージンを0に戻す
        scrollViewBottomConstraint.constant = 0
        
        //アニメーションを利用してキーボードが上がるアニメーションと同じ速度でScrollViewのたBottom制約設定を適応
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
        
        
    }
    
    //scrollview_キーボード_ずらす_ここまで
    
    
    
    //痛み詳細部分 //MARK: 要確認
    @IBAction func painDetailButton(sender: AnyObject) {
        
        guard let button = sender as? UIButton else {
            return
        }
        
        let value_Key = "pain_button\(button.tag)"
        let value = painPlace_Dictionary[value_Key]
        let selectedButton: UIButton! = sender as? UIButton
        
        if value == "なし" {
            painPlace_Dictionary[value_Key] = "あり"
            print("pain_value - あり 変更: \(value_Key)")
            let rgba = Asset.painColor.color
            selectedButton.backgroundColor = rgba
        } else if value == "あり" {
            painPlace_Dictionary[value_Key] = "なし"
            print("pain_value - なし 変更: \(value_Key)")
            let rgba = Asset.clearColor.color
            selectedButton.backgroundColor = rgba
            
        }
        print("痛みチェンジ完了")
        
    }
    
    
    
    
    @IBAction func pain_slider(_ sender: UISlider) {
        let sliderValue :Int = Int(sender.value)
        sender.setValue(sender.value.rounded(.down), animated: false)
        print("painLevel: \(sliderValue)")
        painLebel_String = String(sliderValue)
        painLevel.text = painLebel_String
    }
    
    
    @IBAction func back() {
        
        //痛みの場所が選択されているか取得
        var checkNone_String = "なし"  //MARK: これで確認する
        
        let dictionary_value = Array(painPlace_Dictionary.values)
        
        for n in 0...dictionary_value.count - 1 {
            if checkNone_String == "なし" {
                if dictionary_value[n] == "あり" {
                    checkNone_String = "あり"
                }
            }
        }
        
        //MARK: if文で一つずつ確認していく
        var errorType_String = ""
        
        if checkNone_String != "なし" && painLebel_String != "" &&  painWriting_string != "" {
            //全て入力済
            UserDefaults.standard.set("痛みあり", forKey: "painTF")
            UserDefaults.standard.set(painPlace_Dictionary, forKey: "painPlace")
            UserDefaults.standard.set(painLebel_String, forKey: "painLebel")
            UserDefaults.standard.set(painWriting_string, forKey: "painWriting")
            
            self.navigationController?.popViewController(animated: true)
            
        } else {
            //エラー版
            if checkNone_String == "なし" {
                errorType_String = "場所"
                
            } else if painLebel_String == "" {
                errorType_String = "度合い"
                
            } else if painWriting_string == "" {
                errorType_String = "詳細"
            }
            
            AlertHost.alertDoubleDef(view: self, alertTitle: "痛みの\(errorType_String)が入力されていません", alertMessage: "入力し直しますか？\n痛みなしとして保存しますか？", b1Title: "痛みなしで保存", b1Style: .default, b2Title: "入力し直す") { _ in
                UserDefaults.standard.set("痛みなし", forKey: "painTF")
                
                let array = ["painPlace","painLebel","painWriting"]
                for (value) in array {
                    UserDefaults.standard.removeObject(forKey: value)
                }
            }
            
        }
    }
    
    
    @IBAction func goForm(_ sender: Any) {
        OtherHost.openForm(view: self)
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
