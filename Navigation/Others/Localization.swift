//
//  Localization.swift
//  Navigation
//
//  Created by Марк Пушкарь on 18.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

enum Strings : String {
    
    case RemoveRoutesMenuItem
    case RemoveMapPinsMenuItem
    case CreateRouteMenuItem
    case CreateRouteAlertTitle
    case CreateRouteAlertMessage
    case MapMenuName
    case AlertButtonTitle
    
    case MapBarButton
    case FeedBarButton
    case LogInBarButton
    case FavesBarButton

    var localized : String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
