//
//  LogInCoordinator.swift
//  Navigation
//
//  Created by Марк Пушкарь on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class LogInCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let navigation: UINavigationController
    let factory: ControllerFactory
    private lazy var profile = {
        factory.makeProfile()
    }()
    let checkerFactory = MyLogInFactory()
    
    init(navigation: UINavigationController,factory: ControllerFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let logInVC = LogInViewController()
        logInVC.coordinator = self
        logInVC.delegate = checkerFactory.makeInspector()
        navigation.pushViewController(logInVC, animated: true)
    }
    
    func goToProfile() {

        profile.viewModel.onShowNext = { [weak self] in
            guard let controller = self?.configureNext() else { return }
            self?.navigation.pushViewController(controller, animated: true)
        }
        
        navigation.pushViewController(profile.controller, animated: true)
    }
    
    
    private func configureNext() -> UIViewController {
        let photoVC = PhotosViewController()
        return photoVC
    }
    
}
