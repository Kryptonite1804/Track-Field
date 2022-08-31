//
//  Tabbar.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/08/26.
//

import UIKit

class Tabbar: UITabBarController {

    @IBOutlet weak var Tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = sizeThatFits(size)
                sizeThatFits.height = 200
                return sizeThatFits;
            }
 
 */
        // Do any additional setup after loading the view.
    }
    
    
    /*
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag {
            case 1:
              print("foo1")
            case 2:
              print("foo2")
            case 3:
              print("foo4")
            case 4:
              print("foo5")
            case 5:
              print("foo6")
            default:
              print("bar")
            }
        }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
