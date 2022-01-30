//
//  KeyChainAccess.swift
//  Navigation
//
//  Created by Марк Пушкарь on 27.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeyChainAccess {
    
    private static let appCredentialsKey : String = "credentials_key"
       
    public static func getCredentialsEncryptionKey() -> Data? {
        return KeychainWrapper.standard.data(forKey: KeyChainAccess.appCredentialsKey)
    }

    public static func initializeCredentialsEncryptionKey() {
        let keyFromKeychain = KeyChainAccess.getCredentialsEncryptionKey()
        if keyFromKeychain == nil {
            var key = Data(count: 64)
            _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            }

        if !KeychainWrapper.standard.set(key, forKey: KeyChainAccess.appCredentialsKey) {
            fatalError("saving error")
            }
        }
    }
}


