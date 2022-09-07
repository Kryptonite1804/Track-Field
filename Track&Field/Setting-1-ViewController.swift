//
//  Setting-1-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/08/30.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Setting_1_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usersData_Array: Array<Any> = []
    var usersDataSecond_Array: [[String: Any]] = []
    
    let db = Firestore.firestore()
    var activityIndicatorView = UIActivityIndicatorView()
    
    var userUid: String = ""
    var groupUid: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        
        Auth.auth().addStateDidChangeListener { (auth, user) in

            guard let user = user else {

                return
            }

            self.userUid = user.uid


            //Adultusersコレクション内の情報を取得
            let docRef2 = self.db.collection("Users").document("\(self.userUid)")

            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    let documentdata2 = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data2: \(documentdata2)")


                    self.groupUid = document.data()!["groupUid"] as! String
                    print("groupUid: ",self.groupUid)

                    UserDefaults.standard.set(self.groupUid, forKey: "groupUid")
                    UserDefaults.standard.set(self.userUid, forKey: "userUid")
                    
                    
                    
                    
                    
                    
                    
                    let docRef3 = self.db.collection("Group").document("\(self.groupUid)")

                    docRef3.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let documentdata3 = document.data().map(String.init(describing:)) ?? "nil"
                            print("Document data3: \(documentdata3)")
                            
                                //全て成功
                            
                            self.usersData_Array = document.data()!["member"] as? Array<Any> ?? []
                            
                            self.usersDataSecond_Array = self.usersData_Array as! [[String: Any]]
                            
                            print("ここでしょう")
                            print(self.usersDataSecond_Array)

                            self.tableView.reloadData()
                            
                            self.activityIndicatorView.stopAnimating()  //AIV
                    
                        } else {
                            print("Document3 does not exist")
                            print("練習記録なし")
                            self.activityIndicatorView.stopAnimating()  //AIV
                            
//                            self.alert(title: "練習記録がありません", message: "まだ今日の練習記録がないようです。\n記録画面で記録すると、練習記録が表示されます。")
                            
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                } else {
                    print("Document2 does not exist")

                    self.activityIndicatorView.stopAnimating()  //AIV
//                    self.alert(title: "エラー", message: "各種情報の取得に失敗しました。")
                }
            }

        }
        
        
       
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    //TV - 行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("行数はこちら")
        print(usersDataSecond_Array.count)
        return usersDataSecond_Array.count
    }
    
    
    //TV - 内容決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Setting_1_TableViewCell
        
        print("内容はこちら")
        
        cell.userName_Label?.text = usersDataSecond_Array[indexPath.row]["username"] as? String
        
        let userMode_String = usersDataSecond_Array[indexPath.row]["mode"] as! String
        
        if userMode_String == "player" {
            cell.userMode_IV?.image = UIImage(named: "player_picture")!
            
        } else if userMode_String == "coach" {
            cell.userMode_IV?.image = UIImage(named: "coach_picture")!
        }
        
        
        //cell選択時のハイライトなし
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell  //cellの戻り値を設定
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
