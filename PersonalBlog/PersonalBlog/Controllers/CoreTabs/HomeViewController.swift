//
//  ViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/19.
//
import UIKit

class HomeViewController: UIViewController {
    
    private var allPosts: [(post: BlogPost, owner: String)] = []
    
    private let createPostButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.layer.shadowColor = UIColor.purple.cgColor
        button.layer.shadowOpacity = 1 // higher value -> more visible
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.3
        button.layer.shadowRadius = 10 // higher value -> more blurred
        button.clipsToBounds = false
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var collectionView: UICollectionView?
    
    private var cellViewModels = [[HomeCollectionCellTypes]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(createPostButton)
        createPostButton.addTarget(self, action: #selector(didTapCreatePost), for: .touchUpInside)
        configureCollectionView()
        setupSpinner()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonSize: CGFloat = 55
        createPostButton.frame = CGRect(x: view.width-75, y: view.height-(view.safeAreaInsets.bottom+100), width: buttonSize, height: buttonSize)
        createPostButton.layer.cornerRadius = buttonSize/2
        
        collectionView?.frame = view.bounds
        
        view.bringSubviewToFront(createPostButton)
        
        
    }
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.color = .systemPurple
    }
    
    @objc private func didTapCreatePost() {
        // Make sure to update collectionView with vc completion
        let vc = CreateNewPostViewController()
        vc.completion = { [weak self] in
            self?.allPosts = []
            self?.cellViewModels = []
            self?.fetchData()
            self?.collectionView?.reloadData()
        }
        present(vc, animated: true)
    }
    
    private func fetchData() {
        spinner.startAnimating()
        
        let userGroup = DispatchGroup()
        userGroup.enter()

        var allPosts: [(post: BlogPost, owner: String)] = []
        DataBaseManager.shared.findAllUsers { users in
            defer {
                userGroup.leave()
            }
            print("\nAll user: \(users)\n")
            for user in users {
                userGroup.enter()
                DataBaseManager.shared.getPosts(username: user) { result in
                    DispatchQueue.main.async {
                        defer {
                            userGroup.leave()
                        }
                        
                        switch result {
                        case .success(let posts):
                            print("\n\(user) post count: \(posts.count)\n")
//                            print(posts)
                            allPosts.append(contentsOf: posts.compactMap({
                                (post: $0, owner: user)
                            }))
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
                }
            }
            
        }
        
        userGroup.notify(queue: .main) {
            let group = DispatchGroup()
            self.allPosts = allPosts
            allPosts.forEach { model in
                group.enter()
                self.createViewModel(
                    model: model.post,
                    username: model.owner
                ) { success in
                    defer {
                        group.leave()
                    }
                    if !success {
                        print("Failed to create VM with fetched data")
                    }
                }
            }
            group.notify(queue: .main) {
                self.collectionView?.reloadData()
                self.spinner.stopAnimating()
            }
        }
        
    }
    
    private func createViewModel(
        model: BlogPost,
        username: String,
        completion: @escaping (Bool) -> Void
    ) {
        guard let currentUsername = UserDefaults.standard.string(forKey: "username") else { return }
        StorageManager.shared.getProfilePictureUrl(for: username) { [weak self] url in
            guard let postUrl = URL(string: model.postUrlString),
                  let profilePictureUrl = url else {
                print("Could not get profile picture from storage")
                return
            }
            let isLiked = model.likers.contains(currentUsername)
            
            let postData: [HomeCollectionCellTypes] = [
                .header(
                    viewModel: PostHeaderCollectionViewCellViewModel(
                        username: username,
                        profileImageUrl: profilePictureUrl
                    )
                ),
                .body(
                    viewModel: PostBodyCollectionViewCellViewModel(
                        postImage: postUrl,
                        title: model.title
                    )
                ),
                .actions(
                    viewModel: PostDateTimeLikesCollectionViewCellViewModel(
                        date: model.date,
                        likers: model.likers, 
                        isLiked: isLiked
                    )
                )
            ]
            self?.cellViewModels.append(postData)
            completion(true)
        }
        
    }
    
    private func configureCollectionView() {
        let sectionHeight: CGFloat = 180
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { index, _ in
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
            let headerItem = NSCollectionLayoutItem(layoutSize: headerSize)
            
            let bodySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
            let bodyItem = NSCollectionLayoutItem(layoutSize: bodySize)
            
            let dateActionItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
            let dateActionItem = NSCollectionLayoutItem(layoutSize: dateActionItemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(sectionHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [
                headerItem,
                bodyItem,
                dateActionItem
            ])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0)
            return section
        })
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PostHeaderCollectionViewCell.self, forCellWithReuseIdentifier: PostHeaderCollectionViewCell.identifier)
        
        collectionView.register(PostBodyCollectionViewCell.self, forCellWithReuseIdentifier: PostBodyCollectionViewCell.identifier)
        
        collectionView.register(PostDateTimeLikesCollectionViewCell.self, forCellWithReuseIdentifier: PostDateTimeLikesCollectionViewCell.identifier)

        self.collectionView = collectionView
        

    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = cellViewModels[indexPath.section][indexPath.row]
        
        switch cellType {
        case .header(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostHeaderCollectionViewCell.identifier,
                for: indexPath
            ) as? PostHeaderCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel, index: indexPath.section )
            cell.delegate = self
            return cell
        
        case .body(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostBodyCollectionViewCell.identifier,
                for: indexPath
            ) as? PostBodyCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel, index: indexPath.section)
            cell.delegate = self
            return cell
            
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDateTimeLikesCollectionViewCell.identifier,
                for: indexPath
            ) as? PostDateTimeLikesCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
}

extension HomeViewController: PostBodyCollectionViewCellDelegate {
    func postBodyCollectionViewCellDidTapBodyElement(_ cell: PostBodyCollectionViewCell, index: Int) {
        let tuple = allPosts[index]
        let vc = PostDetailViewController(post: tuple.post, owner: tuple.owner)
        vc.completion = { [weak self] in
            self?.allPosts = []
            self?.cellViewModels = []
            self?.fetchData()
            self?.collectionView?.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: PostHeaderCollectionViewCellDelegate {
    func postHeaderCollectionViewCellDidTapHeader(_ cell: PostHeaderCollectionViewCell, index: Int) {
        let tuple = allPosts[index]
        let vc = ProfileViewController(user: User(name: tuple.owner, email: tuple.owner))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
