//
//  ProfileViewModule.swift
//  Navigation
//
//  Created by Марк Пушкарь on 31.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol ProfileOutput {
    var moduleTitle: String { get }
  //  var header: UITableViewHeaderFooterView { get }
    var onTapShowNextModule: () -> Void { get }
}

final class ProfilelViewModel: ProfileOutput {
    
    var coordinator: LogInCoordinator?
    
//    var header: UITableViewHeaderFooterView {
//        return ProfileHeaderView()
//    }
    
    var moduleTitle: String {
        return "Profile"
    }
    
    // интерфейс для отправки данных в координатор
    var onShowNext: (() -> Void)?
    
    // интерфейс для приема данных от ViewController
    lazy var onTapShowNextModule: () -> Void = { [weak self] in
        self?.onShowNext?()
    }
    

}

 
