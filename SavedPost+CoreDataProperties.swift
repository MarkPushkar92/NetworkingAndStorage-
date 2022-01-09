//
//  SavedPost+CoreDataProperties.swift
//  Navigation
//
//  Created by Марк Пушкарь on 09.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPost> {
        return NSFetchRequest<SavedPost>(entityName: "SavedPost")
    }

    @NSManaged public var author: String?
    @NSManaged public var text: String?
    @NSManaged public var image: URL?
    @NSManaged public var likes: Int16
    @NSManaged public var views: Int16

}

extension SavedPost : Identifiable {

}
