//
//  RegisterViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let header: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Personal_Blog")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let phraseLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore millions of personal stories!"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.numberOfLines = 1
        return label
    }()
    
    private let usernameTextField: SingInUPTextField = {
        let textField = SingInUPTextField()
        textField.placeholder = "Username"
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let emailTextField: SingInUPTextField = {
        let textField = SingInUPTextField()
        textField.placeholder = "Email Address"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: SingInUPTextField = {
        let textField = SingInUPTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
//        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureButtons()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 100
        header.frame = CGRect(
            x: (view.width-imageSize)/2,
            y: view.safeAreaInsets.top,
            width: imageSize,
            height: imageSize
        )
        
        phraseLabel.frame = CGRect(
            x: 0,
            y: header.bottom+10,
            width: view.width,
            height: 20
        )
        
        usernameTextField.frame = CGRect(
            x: 10,
            y: phraseLabel.bottom+30,
            width: view.width-20,
            height: 50
        )
        
        emailTextField.frame = CGRect(
            x: 10,
            y: usernameTextField.bottom+10,
            width: view.width-20,
            height: 50
        )
        passwordTextField.frame = CGRect(
            x: 10,
            y: emailTextField.bottom+10,
            width: view.width-20,
            height: 50
        )
        
        registerButton.frame = CGRect(
            x: 10,
            y: passwordTextField.bottom+20,
            width: view.width-20,
            height: 50
        )
    }
    
    private func addSubviews() {
        view.addSubview(header)
        view.addSubview(phraseLabel)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)


    }
    
    private func configureButtons() {
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    @objc private func didTapRegister() {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            presentError(title: "Sorry", message: "Please be sure all the fields are filled.")
            return
        }
        guard password.count >= 6,
              username.count > 2,
              username.trimmingCharacters(in: .alphanumerics).isEmpty // conditional for special characters
        else {
            presentError(title: "Sorry", message: "Please be sure username and password are longer than 2 and 6 characters respectively and do not include any special characters")
            return
        }
        
        AuthManager.shared.signUp(email: email, username: username, password: password) { [weak self] success in
            if success {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(username, forKey: "username")
                
                DispatchQueue.main.async {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } else {
                self?.presentError(title: "Error", message: "Could not register the user.")
            }
        }
              
    }
    
    private func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
}
