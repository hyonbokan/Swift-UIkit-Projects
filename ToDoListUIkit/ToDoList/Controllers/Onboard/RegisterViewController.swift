//
//  RegisterViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let headerView = OnboardHeaderView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()

    }
    
    private func addSubviews() {
        headerView.configure(backgroundColor: .orange, titleText: "Register", subtitleText: nil, titleColor: .white, subtitleColor: .white)
    }

}
