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
    
    
    
    
    func logIn(email: String, password: String) -> Bool {
        let logInStatus: Bool = {
            var logInStatus = Bool()
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    logInStatus = false
                    print("Status false: \(logInStatus)")
                    return
                }
                print("Signed in")
                logInStatus = true
                print("Status positive: \(logInStatus)")
            }
            print("Status de facto: \(logInStatus)")
            return logInStatus
        }()
        return logInStatus
    }

    func createAccount(email: String, password: String) {
       
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil else {
                    print("Failed to create account")
                    return
                }
                print("Signed UP")
                self.coordinator?.goToProfile()
            }
           
        print("create account func calling")
   
    }
    
    
    
    
//    func logIn(email: String, password: String) {
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            guard error == nil else {
//
//                self.createAccount(email: email, password: password)
//                return
//            }
//            print("Signed in")
//            self.coordinator?.goToProfile()
//        }
//    }
    
    
    
//    func check(userLogin: String, userPassword: String) -> Bool {
//        if userLogin == login, userPassword == password {
//            return true
//        } else {
//            print("wrong Login or Password, try again")
//            return false
//        }
//    }
}


// part of code from LogInViewCOntroller:

//    @objc func buttonTapped() {
//        print("button tapped")
//        if delegate?.check(userLogin: email.text!, userPassword: passwordTextField.text!) == true {
//            coordinator?.goToProfile()
//        } else {
//            print("failed")
//        }
//    }

//func logIn(email: String, password: String) -> Bool {
//    var logInStatus = Bool()
//    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
//        guard error == nil else {
//            logInStatus = false
//            print("Status false: \(logInStatus)")
//            return
//        }
//
//        print("Signed in")
//        self.coordinator?.goToProfile()
//        logInStatus = true
//        print("Status positive: \(logInStatus)")
//
//    }
//    print("Status de facto: \(logInStatus)")
//    return logInStatus
//}
