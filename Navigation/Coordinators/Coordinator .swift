//
//  Coordinator .swift
//  Navigation
//
//  Created by Марк Пушкарь on 27.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
