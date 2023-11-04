//
//  PostViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 10/30/23.
//

import UIKit

class PostDetailViewController: UIViewController {
    var completion: (() -> Void)?
    
    private let post: BlogPost
    
    private let owner: String
    
    private let username = UserDefaults.standard.string(forKey: "username")
    
    private var viewModel: PostDetailCellViewModel?

    private var isLiked: Bool = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "titleCell")
        tableView.register(PostDetailHeaderTableViewCell.self, forCellReuseIdentifier: PostDetailHeaderTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "bodyCell")
        tableView.register(PostDetailFooterTableViewCell.self, forCellReuseIdentifier: PostDetailFooterTableViewCell.identifier)
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.layer.cornerRadius = 20
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.systemPurple.cgColor
        return stackView
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
        fetchPost()
        
        view.addSubview(tableView)
        view.addSubview(stackView)
        configureStackView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let stackViewWidth: CGFloat = 100
        stackView.frame = CGRect(x: (view.width-stackViewWidth)/2 , y: (view.height-view.safeAreaInsets.bottom-55), width: stackViewWidth, height: stackViewWidth/2.5)
           
        tableView.frame = view.bounds
        view.bringSubviewToFront(stackView)
    }
    
    @objc private func didTapMore() {
        print("more button tapped")
    }
    
    private func configureStackView() {
        let likeButton = UIButton()
        let likeImage = UIImage(systemName: "basketball", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        likeButton.setImage(likeImage, for: .normal)
        likeButton.tintColor = .systemPurple
        
        let shareButton = UIButton()
        let shareImage = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        shareButton.setImage(shareImage, for: .normal)
        shareButton.tintColor = .systemPurple
        
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(shareButton)
        
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    @objc private func didTapLike() {
        DataBaseManager.shared.updateLike(
            state: isLiked ? .unlike : .like,
            postID: post.id,
            owner: owner) { [weak self] success in
                guard success,
                      let strongSelf = self else {
                    return
                }
                strongSelf.isLiked = !strongSelf.isLiked
                self?.configureLikeButton()
                self?.completion?()
                print("\nisLiked after liking post data: \(strongSelf.isLiked)\n")
            }
    }
    
    @objc private func didTapShare() {
        print("sharing the post")
        let vc = UIActivityViewController(
            activityItems: ["Sharing from PersonalBlog", post.postUrlString],
            applicationActivities: []
        )
        present(vc, animated: true)
    }
    
    
    private func configureLikeButton() {
        let imageName = isLiked ? "basketball.fill" : "basketball"
        let likeImage = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        if let likeButton = stackView.arrangedSubviews[0] as? UIButton {
            likeButton.setImage(likeImage, for: .normal)
        }
    }
    
    private func configureNavButtons() {
        let shareButtonImage = UIImage(systemName: "ellipsis")?.withTintColor(.systemPurple, renderingMode: .alwaysOriginal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareButtonImage, style: .done, target: self, action: #selector(didTapMore))
    }
    
    private func fetchPost() {
//        let username = owner
//        let post = self.post
//        DataBaseManager.shared.getPosts(username: username) { [weak self] posts in
////            print("Detail Posts -> posts fetched: \(posts)")
//            self?.createViewModel(model: post, username: username, completion: { success in
//                guard success else {
//                    print("Failed to create viewModel for PostDetailViewModel")
//                    return
//                }
//                DispatchQueue.main.async {
////                    self?.isLiked = post.likers.contains(username)
//                    self?.tableView.reloadData()
//                    print("\nisLiked after fetch post data: \(self?.isLiked)\n")
//                }
//            })
//            
//        }
        
        createViewModel(model: post, username: owner) { [weak self] success in
            guard let isLiked = self?.isLiked else {
                return
            }
            guard success else {
                print("Failed to create viewModel for PostDetailViewModel")
                return
            }
            DispatchQueue.main.async {
                self?.configureLikeButton()
                self?.tableView.reloadData()
                print("isLiked after fetch: \(isLiked)")
            }
        }
    }
    
    private func createViewModel(
        model: BlogPost,
        username: String,
        completion: @escaping (Bool) -> Void
    ) {
        StorageManager.shared.getProfilePictureUrl(for: username) { [weak self] url in
            guard let profilePhotoUrl = url,
                  let currentUser = self?.username
            else {
                completion(false)
                return
            }
            print("Who liked the post: \(model.likers)")
            print("currentUser: \(currentUser)")
            
            let isLiked = model.likers.contains(currentUser)
            let postData = PostDetailCellViewModel(title: model.title, username: username, profilePictureUrl: profilePhotoUrl, postImage: URL(string: model.postUrlString), date: model.date, isLiked: isLiked)
            self?.viewModel = postData
            self?.isLiked = postData.isLiked
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
        // Need to refactor the viewModel: [SinglePostCellType] -> header, body, footer
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
            if let viewModel = self.viewModel{
                cell.configure(with: viewModel)
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
            return 280
        case 2:
            return UITableView.automaticDimension
        case 3:
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
    
}
