//
//  Analize-2-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/08/12.
//

import UIKit

class Analize_2_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //セクション
    let sectionData = ["項目","評価","結果"]
    //tableView内容変更
    let tableData = [
        [/*"曜日",*/"練習場所タイプ","食事の回数","チーム","練習タイプ"],
        ["練習評価","痛みの度合い","疲労度"],
        [/*"アップのタイム","ダウンのタイム",*/"アップの距離","ダウンの距離","トータル距離"/*,"睡眠時間"*/]
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    //TV - セクション数指定
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    //TV - セクションの高さ指定
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.textColor = UIColor(red: 174/255, green: 85/255, blue: 247/255, alpha: 1.0)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell.textLabel?.text = tableData[indexPath.section][indexPath.row]
        
        //cell選択時のハイライトなし
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell  //cellの戻り値を設定
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionData[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label: UILabel = UILabel()
        label.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        label.textColor = UIColor(red: 174/255, green: 85/255, blue: 247/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "  \(sectionData[section])"
        return label
    }
    
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let elementcheck = UserDefaults.standard.string(forKey: "elementCheck") ?? ""
        
        
        UserDefaults.standard.set(tableData[indexPath.section][indexPath.row], forKey: "\(String(describing: elementcheck))_value")
        UserDefaults.standard.set(sectionData[indexPath.section], forKey: "\(String(describing: elementcheck))_kind")
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    //    UserDefaults.standard.set(self.username, forKey: "Setup_username")
    //    let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-his-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! History_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedRunningData = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
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
