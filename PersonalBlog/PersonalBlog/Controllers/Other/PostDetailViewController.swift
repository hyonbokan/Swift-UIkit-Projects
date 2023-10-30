//
//  PostViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 10/30/23.
//

import UIKit

class PostDetailViewController: UIViewController {
    private let post: BlogPost
    private let owner: String
    
    init(post: BlogPost, owner: String) {
        self.post = post
        self.owner = owner
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavButtons()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func didTapShare() {
        
    }
    
    
    private func configureNavButtons() {
        let shareButtonImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButtonImage, style: .done, target: self, action: #selector(didTapShare))
    }
    
}

