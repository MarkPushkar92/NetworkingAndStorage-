//
//  BrutForce.swift
//  Navigation
//
//  Created by Марк Пушкарь on 09.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class BrutForcer {
    func bruteForce(passwordToUnlock: String) -> String {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0)
        }
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        print(password)
        return password
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
            : Character("")
    }
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
    
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

