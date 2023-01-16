//
//  FirebaseClient.swift
//  Track&Field
//
//  Created by 山田航輝 on 2022/12/04.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseAuthCombineSwift



enum errorList: Error {
    case getUUIDError
}

class FirebaseClient {
    
    
    static let shared = FirebaseClient()
    
    
    func getUUID() async throws -> String {
        guard let user = Auth.auth().currentUser else {
//            try await self.checkUserAuth()
//            throw FirebaseClientAu
//            UserDefaults.standard.set(useruid, forKey: "userUid")
            throw errorList.getUUIDError
        }
        
        let userUid = user.uid
        return userUid
        
    }
    
    
    
}
