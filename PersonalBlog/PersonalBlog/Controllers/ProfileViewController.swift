//
//  ProfileViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(didTapSignOUt)
        )
        
    }
    
    @objc private func didTapSignOUt() {
        
    }

}
