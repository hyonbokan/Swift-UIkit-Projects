//
//  ViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/19.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let createPostButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .label
        button.backgroundColor = .systemPurple
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(createPostButton)
        createPostButton.addTarget(self, action: #selector(didTapCreatePost), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonSize: CGFloat = 55
        createPostButton.frame = CGRect(x: view.width-75, y: view.height-(view.safeAreaInsets.bottom+100), width: buttonSize, height: buttonSize)
        createPostButton.layer.cornerRadius = buttonSize/2
        
    }
    
    @objc private func didTapCreatePost() {
        let vc = CreateNewPostViewController()
        present(vc, animated: true)
    }

}

