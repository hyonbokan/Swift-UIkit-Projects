//
//  ProfileViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let currentUser: User
    
    private var isCurrentUser: Bool {
        return currentUser.name == UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Profile Label
    private let navLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 40)
//        label.backgroundColor = .red
        return label
    }()
    
    // Profile image
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
//        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
//        label.backgroundColor = .brown
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
//        label.backgroundColor = .brown
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Member Since: "
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
//        label.backgroundColor = .brown
        return label
    }()
    
    // Log out button
    private let logOutButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .green
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(navLabel)
        view.addSubview(profileImage)
        view.addSubview(logOutButton)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(dateLabel)
        
        fetchUserInfo(user: currentUser)
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
        
        nameLabel.frame = CGRect(
            x: 30,
            y: profileImage.bottom+50,
            width: view.width-50,
            height: 30)
        
        emailLabel.frame = CGRect(
            x: 30,
            y: nameLabel.bottom+30,
            width: view.width-50,
            height: 30)
        
        dateLabel.frame = CGRect(
            x: 30,
            y: emailLabel.bottom+30,
            width: view.width-50,
            height: 30)
        
        logOutButton.frame = CGRect(
            x: 0,
            y: dateLabel.bottom + 40,
            width: view.width,
            height: 40
        )
        
    }
    
    private func fetchUserInfo(user: User) {
//        DatabaseManager.shared.findUserInfo(userId: user.id) { [weak self] result in
//            guard result != nil else {
//                print("Couldn't load userInfo from DB")
//                return
//            }
//            DispatchQueue.main.async {
//                self?.nameLabel.text = "Name: \(result?.name ?? "")"
//                self?.emailLabel.text = "Name: \(result?.email ?? "")"
//                self?.dateLabel.text = "Name: \(Date(timeIntervalSince1970: result?.joined ?? Date().timeIntervalSince1970).formatted(date: .abbreviated, time: .shortened))"
//            }
//        }
        self.nameLabel.text = "Name: \(user.name)"
        self.emailLabel.text = "Email: \(user.email)"
        self.dateLabel.text = "Member since: \(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))"
    }
}
