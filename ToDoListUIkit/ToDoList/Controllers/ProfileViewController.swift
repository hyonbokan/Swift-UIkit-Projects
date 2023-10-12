//
//  ProfileViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Profile Label
    private let navLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.backgroundColor = .red
        return label
    }()
    
    // Profile image
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.backgroundColor = .blue
        return imageView
    }()
    // Log out button
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navLabel)
        view.addSubview(profileImage)
        view.addSubview(logOutButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navLabel.frame = CGRect(x: 0, y: 150, width: view.width/3, height: 50)
        let imageSize: CGFloat = view.width/2.5
        profileImage.layer.cornerRadius = imageSize/2
        profileImage.frame = CGRect(
            x: (view.width - imageSize) / 2,
            y: view.width - imageSize,
            width: imageSize,
            height: imageSize
        )
        
        logOutButton.frame = CGRect(
            x: 0,
            y: profileImage.bottom + 20,
            width: view.width,
            height: 40
        )
        
    }
    
}
