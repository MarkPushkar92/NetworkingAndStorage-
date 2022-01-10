//
//  CoreDataStack.swift
//  Navigation
//
//  Created by Марк Пушкарь on 09.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {

    private(set) lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func fetchPosts() -> [SavedPost] {
        let request: NSFetchRequest<SavedPost> = SavedPost.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("🤷‍♂️ Что-то пошло не так..")
        }
    }
    
    func remove(post: SavedPost) {
        viewContext.delete(post)
        
        save(context: viewContext)
    }
    
    func createNewSavedPost(postToSave: MyPost) {
        let newSavedPost = SavedPost(context: viewContext)
        newSavedPost.author = postToSave.author
        newSavedPost.text = postToSave.description
        newSavedPost.likes = Int16(postToSave.likes)
        newSavedPost.views = Int16(postToSave.views)
        newSavedPost.image = {
            let image = postToSave.image
            let data = image.jpegData(compressionQuality: 1.0)
            return data
        }()
        save(context: viewContext)
        print("post's saved")
    }
    
    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

}
