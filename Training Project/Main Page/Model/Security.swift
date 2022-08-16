//
//  Security.swift
//  Training Project
//
//  Created by VironIT on 8/12/22.
//

import Foundation
import KeychainSwift

class Security {
    
   static var shared = Security()
   private var userDefaults = UserDefaults.standard
    
   private var keyChain = KeychainSwift()
    
    private init() {}
    
     func setUsernameInDefalts(username: String, getPinAlert: @escaping () -> Void, setPinAlert: @escaping () -> Void) {
        if UserDefaults.standard.object(forKey: username) != nil {
            getPinAlert()
        } else {
        userDefaults.set(username, forKey: username)
            setPinAlert()
        }
    }
    
    func setPassword(password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    func checkPassword(enteredPassword: String, username: String) -> Bool {
        let passwordInMemory = keyChain.get(username)
        
        return passwordInMemory == enteredPassword
    }
}
