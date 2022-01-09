//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

//MARK: Properties
    
    let networkService = NetWorkService()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()
    
   private var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "No title Yet"
       label.textColor = .black
       label.backgroundColor = .lightGray
       label.translatesAutoresizingMaskIntoConstraints = false
       label.sizeToFit()
       label.numberOfLines = 2
       return label
    }()
    
    private let showTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show title", for: .normal)
        button.addTarget(self, action: #selector(showTitle), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.backgroundColor = .lightGray
        return button
    }()
    
    private let showPlanetInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Planet Info", for: .normal)
        button.addTarget(self, action: #selector(showPlanetInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    
//MARK: funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(button)
        view.addSubview(titleLabel)
        view.addSubview(showTitleButton)
        view.addSubviews(showPlanetInfoButton)
        let constraints = [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showTitleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showTitleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            showPlanetInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPlanetInfoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func showTitle() {
        networkService.startDataTask { recievedTitle in
            if let recievedTitle = recievedTitle {
                print("Show: \(recievedTitle)")
                DispatchQueue.main.async {
                    self.titleLabel.text = recievedTitle
                }
            }
        }
    }
    
    @objc func showPlanetInfo() {
        networkService.startDataTaskForPlanets { planet in
            if let recievedPlanet = planet {
                DispatchQueue.main.async {
                    self.titleLabel.text = recievedPlanet.orbitalPeriod
                }
            }
        }
    }
    
    @objc func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
