//
//  SceneDelegate.swift
//  Track&Field
//
//  Created by 佐野生樹 on 2022/06/05.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var authListener: Any!
    
    let db = Firestore.firestore()
    var userUid: String = ""

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        autoLogin()
        
    }
    
    
    
    //ここから
    
    func autoLogin() {
        authListener = Auth.auth().addStateDidChangeListener({ auth, user in
            //その後呼ばれないようにデタッチする
            Auth.auth().removeStateDidChangeListener(self.authListener! as! NSObjectProtocol)
            if user != nil {
                DispatchQueue.main.async {
                    print("loginされています")
                    //ログインされているのでメインのViewへ
                    
                    
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
                                
                                let userMode_String = document.data()!["mode"] as! String
                                print("mode: ",userMode_String)
                                
                                
                                if userMode_String == "player" {
                                    
                                    self.gotoPlayer()
                                    
                                } else if userMode_String == "coach" {
                                    
                                    self.gotoCoach()
                                    
                                }
                                
                                
                                
                            } else {
                                
                                print("Document2 does not exist")
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
                
            } else {
                
                //認証されていなければ初期画面表示
//                guard let _ = (self.scene as? UIWindowScene) else { return }
                
                DispatchQueue.main.async {
                    //ログインされていない
                    print("loginされていません")
                    self.gotoRegister()
                    
                    
                }
                
                
                
                
            }
        })
    }
     
    
    
    func gotoPlayer() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeP") as! UITabBarController
            window?.rootViewController = vc
    }
    
    func gotoCoach() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeC") as! UITabBarController
            window?.rootViewController = vc
    }
    
    func gotoRegister() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterTop") as! UINavigationController
            window?.rootViewController = vc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

