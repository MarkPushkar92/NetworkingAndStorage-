//
//  NetworkService.swift
//  Navigation
//
//  Created by Марк Пушкарь on 16.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class NetWorkService {
    
    func startDataTask(url: String) {
          if let url = URL(string: url) {
              URLSession.shared.dataTask(with: url) { data, response, error in
                  if error != nil {
                      print("Have Recieved an Error: \(String(describing: error?.localizedDescription))")
                      return
                     }
                   if let data = data {
                       
                       if let jsonString = String(data: data, encoding: .utf8) {
                           print("Recieved data: \(jsonString)")
                           self.jsonSerializator(data: jsonString)
                      }
                   }
                  
              }.resume()
          }
      }
    
    
    private func jsonSerializator(data: String) {
      
        let str = Data(data.utf8)
        
        do {
            if let json = try JSONSerialization.jsonObject(with: str, options: []) as? [String: Any] {
                if let title = json["title"] as? [String] {
                    print(title)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
