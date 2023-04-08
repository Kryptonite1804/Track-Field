//
//  Record_3_ViewController.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/08/30.
//
//必要なし

import UIKit
import SafariServices

class Record_3_ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var edit_picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    
    @IBAction func tap(_ sender: UIButton) {
        edit_picture.image = Asset.pPushedS.image
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        edit_picture.image = Asset.pNonpushedS.image
    }
    
    @IBAction func edit() {
        edit_picture.image = Asset.pNonpushedS.image
        self.navigationController?.popToRootViewController(animated: true)
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
