//
//  Post.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//
import UIKit

struct Post {
    let title: String
}

struct MyPost {
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
}

let cat = MyPost(author: "Dr.gonzo", description: "Oh, my damn cat", image: #imageLiteral(resourceName: "cat"), likes: 1, views: 3)
let line = MyPost(author: "Dr.gonzo", description: "Don't cross the line", image: #imageLiteral(resourceName: "line"), likes: 10, views: 666)
let waiting = MyPost(author: "Dr.gonzo", description: "waiting for my new Iphone", image: #imageLiteral(resourceName: "waiting"), likes: 4, views: 13)
let inst = MyPost(author: "Dr.gonzo", description: "Oh, no!", image: #imageLiteral(resourceName: "dickpick"), likes: 1, views: 1)

let posts: [MyPost] = [cat, line, waiting, inst]

struct PhotosProfile {
    let label: String
    let photo1: UIImage
    let photo2: UIImage
    let photo3: UIImage
    let photo4: UIImage
}

struct StoragePhotoProfile {
    static let tableModel = PhotosProfile(label: "Photos", photo1: #imageLiteral(resourceName: "1"), photo2: #imageLiteral(resourceName: "7"), photo3: #imageLiteral(resourceName: "8"), photo4: #imageLiteral(resourceName: "18"))
}
