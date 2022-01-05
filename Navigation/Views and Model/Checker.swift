//
//  Checker.swift
//  Navigation
//
//  Created by Марк Пушкарь on 25.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import RealmSwift

class Cheker {
    
    weak var coordinator: LogInCoordinator?
    
    static let shared = Cheker()
    
//    private let password = "Password"
//
//    private let login = "Mark.pushkar92@gmail.com"
    
    
    func logIn(email: String, password: String, completion: @escaping (Bool?) -> Void) {
        
        var logInStatus = Bool()
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                logInStatus = false
                print("Status false: \(logInStatus)")
                completion(logInStatus)
                return
            }
            print("Signed in")
            logInStatus = true
            print("Status positive: \(logInStatus)")
            completion(logInStatus)
        }
        print("Status de facto: \(logInStatus)")
        compareUsers(email: email, password: password)
    }
        

    func createAccount(email: String, password: String, completion: @escaping (Bool?) -> Void) {
       FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
           guard error == nil else {
               print("Failed to create account")
               return
            }
            print("Signed UP")
           self.logIn(email: email, password: password, completion: completion)
        }
        print("create account func calling")
   }
    
     func saveUserToRealmDB(email: String, password: String) {
         let realm = try? Realm()
         let realmUserObject = RealmUserModel()
         realmUserObject.email = email
         realmUserObject.password = password
         do {
         realm?.beginWrite()
         realm?.add(realmUserObject)
         try realm?.commitWrite()
         } catch {
             print(error.localizedDescription)
         }
    }
    
    func readRealmUser() -> User? {
        let realm = try? Realm()
        let result : [User] = realm?.objects(RealmUserModel.self).compactMap {
            guard let email = $0.email, let password = $0.password else { return nil }
            return User(email: email, password: password)
        } ?? []
        print("Available Users are  : \(result)")
        
        if result.count != 0 {
            return result[0]
            } else {
            return nil
        }
    }
    
    func compareUsers(email: String, password: String) {
        let lastUser = readRealmUser()
        let user = User(email: email, password: password)
        if user.email == lastUser?.email, user.password == lastUser?.password {
            print("Logining Current User")
        } else {
            saveUserToRealmDB(email: email, password: password)
        }
    }
    
}


