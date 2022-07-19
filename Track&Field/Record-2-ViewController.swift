//
//  Record-2-ViewController.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/07/08.
//

import UIKit

class Record_2_ViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var pain_writing: UITextView!
    
    @IBOutlet weak var painPlace_picture: UIImageView!
    @IBOutlet weak var painStage_picture: UIImageView!
    @IBOutlet weak var painWriting_picture: UIImageView!
    
    @IBOutlet weak var painLevel: UILabel!
    
    var painWriting_string = ""
    
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
        

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    //TV  //TVの「完了」Buttonが押された際の処理
    @objc func onClickCommitButton(sender: UIButton) {
        if(pain_writing.isFirstResponder) {
            pain_writing.resignFirstResponder()
            painWriting_string = pain_writing.text
            print("memoText:\(painWriting_string)")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.painWriting_string = self.pain_writing.text!
            print("memoText: \(self.painWriting_string)")
        }
        return true
    }
    
    
    @IBAction func pain_slider(_ sender: UISlider) {
        let sliderValue :Int = Int(sender.value)
        sender.setValue(sender.value.rounded(.down), animated: false)
        painLevel.text = String(sliderValue)
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
