//
//  LogInViewController.swift
//  Navigation
//
//  Created by Марк Пушкарь on 30.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
       
//MARK: properties
    
    var delegate: LoginViewControllerDelegate?
    
    weak var coordinator: LogInCoordinator?
    
    let logoImage: UIImageView = {
        let logIn = UIImageView()
        logIn.image = UIImage(named: "logo.png")
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
        
    let stackLogIn: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()

    let email: UITextField = {
        let email = UITextField()
        email.placeholder = "  Email or phone"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.backgroundColor = .systemGray6
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderWidth = 0.5
        email.layer.cornerRadius = 10
        email.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        email.textColor = .black
        email.font = .systemFont(ofSize: 16)
        return email
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "  Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        password.backgroundColor = .systemGray6
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.layer.cornerRadius = 10
        password.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        password.isSecureTextEntry = false
        password.textColor = .black
        password.font = .systemFont(ofSize: 16)
        return password
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log In", titleColor: .white) {
            self.buttonTapped()
        }
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var containerView = UIView()
    
//MARK: LOGINFUNC
    
    @objc func buttonTapped() {
        print("button tapped")
        guard let email = email.text, !email.isEmpty ,
              let password = passwordTextField.text, !password.isEmpty else {
                print("missing email or password")
                return
              }
        delegate?.logIn(email: email, password: password, completion: { logInStatus in
                if logInStatus == true {
                    self.coordinator?.goToProfile()
                } else {
                    self.createAccount(email: email, password: password)
                }
        })
    }
        
                                     
                                     
    
    func createAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Create Account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.delegate?.createAccount(email: email, password: password)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                            
        }))
        present(alert, animated: true, completion: nil)
    }

    
//MARK: life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        [logoImage,stackLogIn,logInButton].forEach {
            containerView.addSubview($0)
            stackLogIn.addArrangedSubview(email)
            stackLogIn.addArrangedSubview(passwordTextField)
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
        
//MARK: Layout
    
    override func viewDidLayoutSubviews() {
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            
            stackLogIn.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackLogIn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackLogIn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackLogIn.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.leadingAnchor.constraint(equalTo: stackLogIn.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: stackLogIn.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: stackLogIn.bottomAnchor, constant: 16),
            logInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: LogIn and Password Checking delegate

protocol LoginViewControllerDelegate: AnyObject {
    
    func logIn(email: String, password: String, completion: @escaping (Bool?) -> Void)
    
    func createAccount(email: String, password: String)

    
}

class LogInInspector: LoginViewControllerDelegate {
    
    func logIn(email: String, password: String, completion: @escaping (Bool?) -> Void) {
        return Cheker.shared.logIn(email: email, password: password, completion: completion)
    }
    
    func createAccount(email: String, password: String) {
        return Cheker.shared.createAccount(email: email, password: password)
    }
}

//MARK: extension alpha

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
    
   
