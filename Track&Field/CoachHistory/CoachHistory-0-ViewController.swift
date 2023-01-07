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
    
//    var usersData_Array: Array<Any> = []
    var member_Array: [[String: String]] = []
    
//    let db = Firestore.firestore()
    var activityIndicatorView = UIActivityIndicatorView()
    
    var userUid: String = ""
    var groupUid: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //AIV
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        activityIndicatorView.startAnimating()
        
        
        let task = Task {
            do {
                self.userUid = try await FirebaseClient.shared.getUUID() //FirebaseClient Class UUIDの取得
                
                
                //Adultusersコレクション内の情報を取得
//                let docRef2 = self.db.collection("Users").document("\(self.userUid)")
//
//                docRef2.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data2: \(documentdata2)")
                        
                        
//                        self.groupUid = document.data()!["groupUid"] as! String
//                        print("groupUid: ",self.groupUid)
                        
                 var userData = try await FirebaseClient.shared.getUserData()
                self.groupUid = userData.groupUid ?? ""
                
                        UserDefaults.standard.set(self.groupUid, forKey: "groupUid")
                        UserDefaults.standard.set(self.userUid, forKey: "userUid")
                        
                        
                        
                        
                        
                        
                        
//                        let docRef3 = self.db.collection("Group").document("\(self.groupUid)")
//
//                        docRef3.getDocument { (document, error) in
//                            if let document = document, document.exists {
//                                let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
//                                print("Document data3: \(documentdata3)")
                                
                                //全て成功
                
                var groupData = try await FirebaseClient.shared.getGroupData()
                                
//                                self.usersData_Array = document.data()!["member"] as? Array<Any> ?? []
                                
//                                self.usersDataSecond_Array = self.usersData_Array as! [[String: Any]]
                                
                self.member_Array = groupData.member ?? [[:]]
                
                                print("ここでしょう")
                                print(self.member_Array)
                                
                                //選手のみ取り出し開始
                                
                                var playersData: [[String: String]] = []
                                var coachesData: [[String: String]] = []
                                
                                
                                for s in 0...self.member_Array.count - 1 {
                                    
                                    let electedDictionary = self.member_Array[s]
                                    
                                    if electedDictionary["mode"] == "player" {
                                        playersData.append(electedDictionary)
                                    } else if electedDictionary["mode"] == "coach" {
                                        coachesData.append(electedDictionary)
                                    }
                                    
                                }
                                
                                
                                self.member_Array = []
                                
                                
                                //コーチは除外
                                //                            if coachesData.count != 0 {
                                //
                                //                            for t in 0...coachesData.count {
                                //
                                //                                let electedCoach = coachesData[t]
                                //                                self.usersDataSecond_Array.append(electedCoach)
                                //
                                //                            }
                                //
                                //                            }
                                
                                //                            if playersData.count != 0 {
                                //
                                //                            for t in 0...playersData.count - 1 {
                                //
                                //                                let electedPlayer = playersData[t]
                                //                                self.usersDataSecond_Array.append(electedPlayer)
                                //
                                //                            }
                                //
                                //                            }
                                
                                self.member_Array = playersData
                                
                                //選手のみ取り出し終了
                                
                                
                                
                                
                                
                                
                                self.tableView.reloadData()
                                
                                self.activityIndicatorView.stopAnimating()  //AIV
                                
//                            } else {
//                                print("Document3 does not exist")
//                                print("練習記録なし")
//                                self.activityIndicatorView.stopAnimating()  //AIV
//
//                                //                            self.alert(title: "練習記録がありません", message: "まだ今日の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
//
//                            }
//                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
//                    } else {
//                        print("Document2 does not exist")
//
//                        self.activityIndicatorView.stopAnimating()  //AIV
//                        //                    self.alert(title: "エラー", message: "各種情報の取得に失敗しました。")
//                    }
//                }
                
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
        
        //        皆playerなので除外
        //        let userMode_String = usersDataSecond_Array[indexPath.row]["mode"] as! String
        
        //        if userMode_String == "player" {
        //            cell.userMode_IV?.image = UIImage(named: "player_picture")!
        //
        //        } else if userMode_String == "coach" {
        //            cell.userMode_IV?.image = UIImage(named: "coach_picture")!
        //        }
        
        //cell選択時のハイライトなし
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell  //cellの戻り値を設定
    }
    
    
    
    //TV - タップ時画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        
        let selectedPlayer = member_Array[indexPath.row]  //選択した行のデータを定数selectedRunningDataに格納
        
        
        performSegue(withIdentifier: "go-CoachHis-1", sender: selectedPlayer)


        }



//    UserDefaults.standard.set(self.username, forKey: "Setup_username")
//    let groupnameload = UserDefaults.standard.string(forKey: "Setup_groupname") ?? "デフォルト値"

    //TV - 画面遷移時配列受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //segueを使用するため
        if segue.identifier == "go-CoachHis-1" {  //toDetailのsegueに対する処理を行い、詳細画面へデータを引き継ぐ
            let nextVC = segue.destination as! CoachHistory_1_ViewController  //次の画面である「計測履歴 詳細画面」を取得する
            nextVC.selectedPlayer = sender as! [String: Any]  //次の画面である「計測履歴 詳細画面」にラン記録を引き継ぐ
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
