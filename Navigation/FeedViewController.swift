//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    
//MARK: Properties
    var model: Model
    
    private var infoVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to InfoVC", for: .normal)
        button.backgroundColor = .gray
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.sizeToFit()
        button.addTarget(self, action: #selector(showInFoVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false 
        return button
    }()
    
    private var responseLabel: UILabel! = {
        let responseLabel = UILabel()
        responseLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        responseLabel.text = "Hell Yeah"
        responseLabel.translatesAutoresizingMaskIntoConstraints = false
        return responseLabel
    }()
    
    private lazy var button: CustomButton = {
        let button = CustomButton(title: "Hit Da Button", titleColor: .white) {
            self.tapped()
        }
        button.backgroundColor = .blue
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        return button
    }()
    
    private lazy var textInput: CustomTextField = {
        let textInput = CustomTextField(placeholder: "какой-то текст") {_ in
            self.onText()
        }
        textInput.backgroundColor = .systemGray6
        textInput.layer.borderColor = UIColor.lightGray.cgColor
        textInput.layer.borderWidth = 0.5
        textInput.layer.cornerRadius = 10
        textInput.textColor = .black
        textInput.font = .systemFont(ofSize: 16)
        return textInput
    }()
    
    func onText() {
    }
    
    func tapped() {
        let res = model.checker(textInput.text!)
        if res == true {
            responseLabel.textColor = .green
            print("green")
        } else {
            responseLabel.textColor = .red
            print("red")
        }
    }
    
    @objc private func showInFoVC() {
        navigationController?.pushViewController(InfoViewController(), animated: true)
    }

//MARK: LayOut

    private func layout() {
        view.addSubview(textInput)
        view.addSubview(button)
        view.addSubview(responseLabel)
        view.addSubviews(infoVCButton)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            textInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textInput.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textInput.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            responseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            responseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            infoVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250)
        ])
    }
    
    

//MARK: LifeCycle
    
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        view.backgroundColor = .darkGray
        layout()
    }

}

