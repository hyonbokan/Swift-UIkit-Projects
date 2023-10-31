//
//  TabBarViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = UserDefaults.standard.string(forKey: "email"),
              let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        let currentUser = User(name: username, email: email)
        print("\ncurrent user: \(currentUser)\n")
        let home = HomeViewController()
        home.title = "Home"
        let profile = ProfileViewController(user: currentUser)
        profile.title = "Profile"
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        self.setViewControllers([nav1, nav2], animated: false)
        
        tabBar.tintColor = .purple
    }
    
}
