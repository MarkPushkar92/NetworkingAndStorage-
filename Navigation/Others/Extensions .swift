//
//  Extensions .swift
//  Navigation
//
//  Created by Марк Пушкарь on 24.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
     static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
         guard #available(iOS 13.0, *) else {
             return lightMode
         }
         
         return UIColor { (traitCollection) -> UIColor in
             return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
         }
     }
 }
