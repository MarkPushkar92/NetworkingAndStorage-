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
import SwiftUI

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
    
    
    var backgroundContext: NSManagedObjectContext {
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
    
    func fetchSavedPostByAuthor(author : String) -> [SavedPost] {
        let request: NSFetchRequest<SavedPost> = SavedPost.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", author)
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Search error")
        }
    }
    
    func remove(post: SavedPost) {
        viewContext.delete(post)

        save(context: viewContext)
    }
    
    func createNewPost(post : MyPost) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let this = self else {return}
            this.createNewSavedPost(postToSave: post, context: this.backgroundContext)
        }
    }
    
    func createNewSavedPost(postToSave: MyPost, context : NSManagedObjectContext) {
        let newSavedPost = SavedPost(context: context)
        newSavedPost.author = postToSave.author
        newSavedPost.text = postToSave.description
        newSavedPost.likes = Int16(postToSave.likes)
        newSavedPost.views = Int16(postToSave.views)
        newSavedPost.image = {
            let image = postToSave.image
            let data = image.jpegData(compressionQuality: 1.0)
            return data
        }()
        save(context: context)
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
