//
//  TabBarViewController.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let username = UserDefaults.standard.string(forKey: "username"),
              let userId = UserDefaults.standard.string(forKey: "userId"),
              let email = UserDefaults.standard.string(forKey: "email"),
              let date = UserDefaults.standard.value(forKey: "joinedDate") as? TimeInterval
        else {
            print("Cannot load tab bar vc")
            return
        }
//        print(date)
//        let joinedDate = Date(timeIntervalSince1970: date)
        let currentUser = User(id: userId, name: username, email: email, joined: date)

        let home = MainViewController()
        let profile = ProfileViewController(user: currentUser)
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: profile)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1
        )
        nav2.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        
        self.setViewControllers([nav1, nav2], animated: false)
        
        tabBar.tintColor = .label
    }

}
