//
//  Security.swift
//  Training Project
//
//  Created by VironIT on 8/12/22.
//

import Foundation
import KeychainSwift

enum Security {
    
   static var userDefaults = UserDefaults.standard
    
   static var keyChain = KeychainSwift()
    
    static func setUsernameInDefalts(username: String, getPinAlert: @escaping () -> Void, setPinAlert: @escaping () -> Void) {
        if UserDefaults.standard.object(forKey: username) != nil {
            getPinAlert()
        } else {
        userDefaults.set(username, forKey: username)
            setPinAlert()
        }
    }
    
    static func setPassword(password: String, username: String) {
        keyChain.set(password, forKey: username)
    }
    
    static func checkPassword(enteredPassword: String, username: String) -> Bool {
        let passwordInMemory = keyChain.get(username)
        
        return passwordInMemory == enteredPassword
    }
}
