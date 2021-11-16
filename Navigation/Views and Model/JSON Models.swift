//
//  JSON Models.swift
//  Navigation
//
//  Created by Марк Пушкарь on 16.11.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct DemoJsn: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
