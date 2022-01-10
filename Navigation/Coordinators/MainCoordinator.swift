//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Марк Пушкарь on 27.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let tabBarController: TabBarViewController
    let model = Model()
    let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarViewController()
        let feed = configureFeed()
        let logIn = configureProfile()
        let faves = configureFaves()
        coordinators.append(logIn)
        tabBarController.viewControllers = [feed, logIn.navigation, faves]
        logIn.start()
    }
    
    private func configureFeed() -> UINavigationController {
        let feedController = FeedViewController(model: model)
        let navigationFirst = UINavigationController(rootViewController: feedController)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage.init(systemName: "house.fill"), tag: 0)
        return navigationFirst
    }
    
    private func configureProfile() -> LogInCoordinator {
        let navigationSecond = UINavigationController()
        navigationSecond.tabBarItem = UITabBarItem(
            title: "Log In",
            image: UIImage.init(systemName: "person.fill"), tag: 1)
        let coordinator = LogInCoordinator(navigation: navigationSecond, factory: factory)
        return coordinator
    }
    
    private func configureFaves() -> UINavigationController {
        let favesController = PostViewController(stack: CoreDataStack())
        let navigationFirst = UINavigationController(rootViewController: favesController)
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage.init(systemName: "heart.fill"), tag: 0)
        return navigationFirst
    }

}
