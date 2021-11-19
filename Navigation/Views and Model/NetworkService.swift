//
//  NetworkService.swift
//  Navigation
//
//  Created by Марк Пушкарь on 16.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class NetWorkService {
    
    //MARK: Return Title
    
    func startDataTask(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/2")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard let data = data else {return}
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Recieved data: \(String(describing: jsonString))")
                let recievedTitle = self.jsonSerializator(data: jsonString)
                completion(recievedTitle)
            }
        })
        task.resume()
    }
    
    private func jsonSerializator(data: String) -> String {
        var recievedTitle = ""
        let str = Data(data.utf8)
        do {
            if let json = try JSONSerialization.jsonObject(with: str, options: []) as? [String: Any] {
                if let title = json["title"] as? String {
                    recievedTitle = title
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            let emptyTitle = "No Title Recieved"
            recievedTitle = emptyTitle
        }
        return recievedTitle
    }
    
    //MARK: Return tatuin
    
    func startDataTaskForPlanets(completion: @escaping (Planet?) -> Void) {
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                print("Error reciever requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            guard let data = data else {return}
            let decode = self.decodeJSON(type: Planet.self, from: data)
            completion(decode)
        })
        task.resume()
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}



