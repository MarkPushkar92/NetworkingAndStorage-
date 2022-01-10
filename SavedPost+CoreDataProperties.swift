//
//  SavedPost+CoreDataProperties.swift
//  
//
//  Created by Марк Пушкарь on 10.01.2022.
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
    @NSManaged public var image: Data?
    @NSManaged public var likes: Int16
    @NSManaged public var views: Int16

}
