//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let headerView = OnboardHeaderView()
    
    private let usernameField: TextField = {
        let textField = TextField()
        textField.placeholder = "Full Name"
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let emailField: TextField = {
        let textField = TextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let password: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
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
        
        usernameField.frame = CGRect(x: 25, y: headerView.bottom, width: view.width-50, height: fieldHeight)
        
        emailField.frame = CGRect(x: 25, y: usernameField.bottom+10, width: view.width-50, height: fieldHeight)
        
        password.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: fieldHeight)
        
        registerButton.frame = CGRect(x: 45, y: password.bottom+10, width: view.width-90, height: fieldHeight)
    }
    
    private func addSubviews() {
        headerView.configure(backgroundColor: .orange, titleText: "Register", subtitleText: nil, titleColor: .white, subtitleColor: .white)
        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(password)
        view.addSubview(registerButton)
    }
    
    private func addButtonActions() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    @objc private func didTapRegister() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        password.resignFirstResponder()
        guard
            let name = usernameField.text,
            let email = emailField.text,
            let password = password.text,
            !name.trimmingCharacters(in: .whitespaces).isEmpty,
            !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty,
            password.count >= 6,
            name.count > 2,
            name.trimmingCharacters(in: .alphanumerics).isEmpty
        else {
            // Ideally, it should be broken into multiple guard statements so it is clear to user where exactly the problem is.
            presentError(title: "Sorry", message: "Please be sure all the fields are filled, and username and password must be longer than 2 and 6 characters respectively")
            return
        }
        
        AuthManager.shared.register(name: name, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    UserDefaults.standard.set(user.email, forKey: "email")
                    UserDefaults.standard.set(user.name, forKey: "name")
                    
                    self?.navigationController?.popToRootViewController(animated: true)
                case .failure(let error):
                    print("\(error)")
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
