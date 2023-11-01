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
    private var viewModel: PostDetailHeaderCellViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleCell")
        tableView.register(PostDetailHeaderTableViewCell.self, forCellReuseIdentifier: PostDetailHeaderTableViewCell.identifier)
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
        
        fetchPost()
        
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
    
    private func fetchPost() {
        let username = owner
        let post = self.post
        DataBaseManager.shared.getPosts(username: username) { [weak self] posts in
//            print("Detail Posts -> posts fetched: \(posts)")
            self?.createViewModel(model: post, username: username, completion: { success in
                guard success else {
                    print("Failed to create viewModel for PostDetailViewModel")
                    return
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
            
        }
    }
    
    private func createViewModel(
        model: BlogPost,
        username: String,
        completion: @escaping (Bool) -> Void
    ) {
        StorageManager.shared.getProfilePictureUrl(for: username) { [weak self] url in
            guard let profilePhotoUrl = url else {
                completion(false)
                return
            }
            let postData = PostDetailHeaderCellViewModel(title: model.title, username: username, profilePictureUrl: profilePhotoUrl, postImage: URL(string: model.postUrlString))
            self?.viewModel = postData
            completion(true)
        }
    }
    
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch index {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.title
            cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            cell.textLabel?.textAlignment = .left
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostDetailHeaderTableViewCell.identifier,
                for: indexPath
            ) as? PostDetailHeaderTableViewCell else {
                fatalError()
            }
            if let viewModel = self.viewModel{
                cell.configure(with: viewModel)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "bodyCell", for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = post.body
            cell.textLabel?.textAlignment = .left
            return cell
        case 3:
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
            return UITableView.automaticDimension
        case 1:
            return 335
        case 2:
            return UITableView.automaticDimension
        case 3:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
}
