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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostDetailHeaderTableViewCell.self, forCellReuseIdentifier: PostDetailHeaderTableViewCell.identifier)
//        tableView.register(PostDetailBodyTableViewCell.self, forCellReuseIdentifier: PostDetailBodyTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "bodyCell")
        tableView.register(PostDetailFooterTableViewCell.self, forCellReuseIdentifier: PostDetailFooterTableViewCell.identifier)
        return tableView
    }()
    
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
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func didTapShare() {
        
    }
    
    
    private func configureNavButtons() {
        let shareButtonImage = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButtonImage, style: .done, target: self, action: #selector(didTapShare))
    }
    
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostDetailHeaderTableViewCell.identifier,
                for: indexPath
            ) as? PostDetailHeaderTableViewCell else {
                fatalError()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bodyCell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.body
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostDetailFooterTableViewCell.identifier,
                for: indexPath
            ) as? PostDetailFooterTableViewCell else {
                fatalError()
            }
            return cell
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        switch index {
        case 0:
            return 250
        case 1:
            return UITableView.automaticDimension
        case 2:
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
    
}
