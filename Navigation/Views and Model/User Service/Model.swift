//
//  Model.swift
//  Navigation
//
//  Created by Марк Пушкарь on 07.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol ModelChecker {
    var checker: ((String) -> Bool) { get }
}

class Model: ModelChecker {
    
    private static let password = "Password"
    
    var checker: ((_ word: String) -> Bool) = { word in
        let result = word == password
        return result
        
    }
}


