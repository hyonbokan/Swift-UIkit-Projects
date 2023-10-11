//
//  LogInViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class LogInViewController: UIViewController {

    private let headerView = OnboardHeaderView()
    
    private let emailField: TextField = {
        let textField = TextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordField: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "New User?"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .label
//        label.backgroundColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private let registerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        addButtonActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/2.0)
        
        let fieldHeight: CGFloat = 40
        
        emailField.frame = CGRect(x: 25, y: headerView.bottom, width: view.width-50, height: fieldHeight)
        
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: fieldHeight)
        
        logInButton.frame = CGRect(x: 45, y: passwordField.bottom+10, width: view.width-80, height: fieldHeight)
        
        registerLabel.frame = CGRect(x: 0, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width, height: 40)
        registerButton.frame = CGRect(x: 0, y: view.height - view.safeAreaInsets.bottom - 60, width: view.width, height: 40)
    }
    
    private func addSubviews() {
        headerView.configure(
            backgroundColor: .systemPink,
            titleText: "To Do List",
            subtitleText: "Get Things Done!",
            titleColor: .white,
            subtitleColor: .white
        )
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(logInButton)
        view.addSubview(registerLabel)
        view.addSubview(registerButton)
    }
    
    private func addButtonActions() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
    }
    
    @objc private func didTapRegister() {
        print("Register button tapped")
        let vc = RegisterViewController()
//        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogIn() {
        print("Log In button tapped")
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        // trimmingCharacters - trim the space
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
        email.contains("@") && email.contains(".") else {
            presentError(title: "Type Error", message: "Be sure to fill email and password correctly.")
            return
        }
        
        AuthManager.shared.logIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                case .failure:
                    self?.presentError(title: "Log In Error", message: "User does not exist. Please be sure your email and password are correct.")
                }
            }
        }
    }
    
    private func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}
