//
//  RealmDBCredencialsModel.swift
//  Navigation
//
//  Created by Марк Пушкарь on 27.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class CashedRealmCredentials: Object {
    dynamic var id: String?
    dynamic var email: String?
    dynamic var password: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class RealmCredentials {
    let id: String
    let email: String
    let password: String
    
    init(id: String, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}

class RealmCredentialsProvider {
    
    private var realm: Realm?
    
    init(encryptionKey : Data) {
        print("encryption key : \(encryptionKey)")
        var config = Realm.Configuration()
        config.encryptionKey = encryptionKey
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("app_user_credentials_encrypted.realm")
        realm = try? Realm(configuration: config)
    }
    
    func getCredentials(userId : String) -> RealmCredentials? {
        let credentials = realm?.object(ofType: CashedRealmCredentials.self, forPrimaryKey: userId)
        if let credentials = credentials {
            let ret = RealmCredentials(id: credentials.id ?? "",
                                       email: credentials.email ?? "",
                                       password: credentials.password ?? "")
            return ret
        } else {
            return nil
        }
    }
    
    func addCredentials(credentials: RealmCredentials) {
        let cachedCredentials = CashedRealmCredentials()
        cachedCredentials.id = credentials.id
        cachedCredentials.email = credentials.email
        cachedCredentials.password = credentials.password
        
        try? realm?.write {
            realm?.add(cachedCredentials)
        }
    }
}

enum UserID {
    static let userId : String = "App_User"
}
