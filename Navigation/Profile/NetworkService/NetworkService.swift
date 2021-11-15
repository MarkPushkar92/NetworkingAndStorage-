//
//  NetworkService.swift
//  Navigation
//
//  Created by Марк Пушкарь on 03.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static func request() {
        
    }
    
    func startDataTask(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Have Recieved an Error: \(String(describing: error?.localizedDescription))")
                    //Have Recieved an Error: Optional("The Internet connection appears to be offline.")
                       return
                   }
                 if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Recieved data: \(jsonString)")
                        }
                 }
                if let httpResponse = response as? HTTPURLResponse {
                        print("All Headers Fields \(httpResponse.allHeaderFields), and Status Code: \(httpResponse.statusCode)")
                         }
            }.resume()
        }
    }
}


