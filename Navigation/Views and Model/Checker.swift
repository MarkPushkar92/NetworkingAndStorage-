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
    }
        

    
    
    func createAccount(email: String, password: String) {
       FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
           guard error == nil else {
               print("Failed to create account")
               return
            }
            print("Signed UP")
            logIn(email: <#T##String#>, password: <#T##String#>, completion: <#T##(Bool?) -> Void#>)
        }
        print("create account func calling")
   }
}


