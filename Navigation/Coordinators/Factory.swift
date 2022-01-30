//
//  Factory.swift
//  Navigation
//
//  Created by Марк Пушкарь on 28.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

import UIKit

protocol ControllerFactory {
    func makeProfile() -> (viewModel: ProfilelViewModel, controller: ProfileViewController)

}

struct ControllerFactoryImpl: ControllerFactory {
    
    func makeProfile() -> (viewModel: ProfilelViewModel, controller: ProfileViewController) {
        let viewModel = ProfilelViewModel()
        let settingsController = ProfileViewController(profileViewModel: viewModel)
        return (viewModel, settingsController)
    }
}

// MARK: INSPECTOR FACTORY

protocol LoginFactory {
    
    func makeInspector() -> LogInInspector
    
}

struct MyLogInFactory: LoginFactory {
    
    func makeInspector () -> LogInInspector {
        return LogInInspector()
    }
}
