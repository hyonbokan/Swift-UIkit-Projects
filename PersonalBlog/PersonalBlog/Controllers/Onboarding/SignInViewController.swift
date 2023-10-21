//
//  SignInViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class SignInViewController: UIViewController {
    
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
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Sign In"
        addSubviews()
        configureButtons()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if !IAPManager.shared.isPremium() {
                let vc = PayWallViewController()
                let navVC = UINavigationController(rootViewController: vc)
                self.present(navVC, animated: true, completion: nil)
            }
        }
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
        
        emailTextField.frame = CGRect(
            x: 10,
            y: phraseLabel.bottom+30,
            width: view.width-20,
            height: 50
        )
        passwordTextField.frame = CGRect(
            x: 10,
            y: emailTextField.bottom+10,
            width: view.width-20,
            height: 50
        )
        
        signInButton.frame = CGRect(
            x: 10,
            y: passwordTextField.bottom+20,
            width: view.width-20,
            height: 50
        )
        signUpButton.frame = CGRect(
            x: 10,
            y: signInButton.bottom+20,
            width: view.width-20,
            height: 50
        )
    }
    
    private func addSubviews() {
        view.addSubview(header)
        view.addSubview(phraseLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
    }
    
    private func configureButtons() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            presentError(title: "Sorry", message: "Please be sure all the fields are filled.")
            return
        }
        AuthManager.shared.signIn(email: email, password: password) { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(email, forKey: "email")
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } else {
                self?.presentError(title: "Error", message: "Failed to sign in. Please check if email and password are correct.")
            }
        }
    }
    @objc private func didTapSignUp() {
        let vc = SignUpViewController()
        vc.title = "Create Account"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
}
