//
//  Setting-1-ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/08/30.
//
//OK

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class Setting_1_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var member_Array: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        //TV
        tableView.delegate = self
        tableView.dataSource = self
        
        OtherHost.activityIndicatorView(view: view).startAnimating()
        
        let task = Task {
            do {
                
                var groupData =  try await FirebaseClient.shared.getGroupData()
                
                member_Array = groupData.member ?? [[:]]
                print("ここでしょう")
                print(self.member_Array)
                
                //指導者 - 選手 順の取り出し 開始
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
                
                //コーチ追加
                if coachesData.count != 0 {
                    
                    for t in 0...coachesData.count - 1 {
                        let electedCoach = coachesData[t]
                        self.member_Array.append(electedCoach)
                    }
                }
                
                if playersData.count != 0 {
                    
                    for t in 0...playersData.count - 1 {
                        let electedPlayer = playersData[t]
                        self.member_Array.append(electedPlayer)
                    }
                }
                
                //指導者 - 選手 順の取り出し 完了
                
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Setting_1_TableViewCell
        
        print("内容はこちら")
        
        cell.userName_Label?.text = member_Array[indexPath.row]["username"]
        
        let userMode_String = member_Array[indexPath.row]["mode"]
        
        if userMode_String == "player" {
            cell.userMode_IV?.image = Asset.playerPicture.image
            
        } else if userMode_String == "coach" {
            cell.userMode_IV?.image = Asset.coachPicture.image
        }
        
        return cell  //cellの戻り値を設定
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
