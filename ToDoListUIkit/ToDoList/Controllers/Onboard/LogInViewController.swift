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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/2.0)
        
        emailField.frame = CGRect(x: 25, y: headerView.bottom+20, width: view.width-50, height: 50)
        
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        
        logInButton.frame = CGRect(x: 45, y: passwordField.bottom+20, width: view.width-90, height: 50)
        
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
    

}
