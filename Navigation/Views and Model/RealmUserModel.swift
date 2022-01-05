//
//  RealmUserModel.swift
//  Navigation
//
//  Created by Марк Пушкарь on 05.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserModel: Object {

    @objc dynamic var email: String?
    @objc dynamic var password: String?
        
}


final class User {
     let email: String
     let password: String

     init(email: String, password: String) {
         self.email = email
         self.password = password
     }
}


