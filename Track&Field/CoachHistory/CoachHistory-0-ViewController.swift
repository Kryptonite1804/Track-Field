//
//  CoachHistory-0-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/09/10.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class CoachHistory_0_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var member_Array: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {
            do {
                
                let groupData = try await FirebaseClient.shared.getGroupData()
                self.member_Array = groupData.member ?? [[:]]
                print(self.member_Array)
                
                //選手のみ取り出し開始
                var playersData: [[String: String]] = []
                
                for s in 0...self.member_Array.count - 1 {
                    let electedDictionary = self.member_Array[s]
                    if electedDictionary["mode"] == "player" {
                        playersData.append(electedDictionary)
                    }
                }
                
                self.member_Array = playersData
                
                //選手のみ取り出し終了
                self.tableView.reloadData()
                OtherHost.activityIndicatorView(view: view).stopAnimating()
            }
            catch {
                print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("行数はこちら")
        print(member_Array.count)
        return member_Array.count
    }
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CoachHistory_0_TableViewCell
        print("内容はこちら")
        cell.userName_Label?.text = member_Array[indexPath.row]["username"]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none //cell選択時のハイライトなし
        
        return cell  //cellの戻り値を設定
    }
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedPlayer = member_Array[indexPath.row]  //選択した行のデータを定数selectedRunningDataに格納
        performSegue(withIdentifier: "go-CoachHis-1", sender: selectedPlayer)
    }
    
    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-CoachHis-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! CoachHistory_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedPlayer = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
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
