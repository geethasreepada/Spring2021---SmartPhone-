//
//  KeychainService.swift
//  Yammer
//
//  Created by alkadios on 4/26/21.
//

import Foundation
import KeychainSwift

class KeychainService{
    
    var _localVar = KeychainSwift()
    
    var keyChain : KeychainSwift{
        get {
            return _localVar
        }
        set {
            _localVar = newValue
        }
    }
    
}
