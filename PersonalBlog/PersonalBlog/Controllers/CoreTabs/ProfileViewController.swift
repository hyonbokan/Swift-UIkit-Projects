//
//  ProfileViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit
import PhotosUI

class ProfileViewController: UIViewController {
    
    private let user: User
    
    private var collectionView: UICollectionView?
    
    private var headerViewModel: ProfileHeaderViewModel?
    
    private var posts: [BlogPost] = []
    
    private var observer: NSObjectProtocol?
    
    let refreshControl = UIRefreshControl()
    
    private var isCurrentUser: Bool {
        return user.name == UserDefaults.standard.string(forKey: "username")
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        refreshControl.addTarget(self, action: #selector(didReshresh), for: .valueChanged)
        if isCurrentUser {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Sign Out",
                style: .done,
                target: self,
                action: #selector(didTapSignOUt)
            )
        }
        configureCollectionView()
        setupSpinner()
        fetchData()
        
        if isCurrentUser {
            observer = NotificationCenter.default.addObserver(forName: .didPostNotification, object: nil, queue: .main
            ) { [weak self] _ in
                self?.posts.removeAll()
                self?.fetchData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    @objc private func didTapSignOUt() {
        let ac = UIAlertController(title: "Do you want to sign out?", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] success in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(nil, forKey: "email")
                        UserDefaults.standard.set(nil, forKey: "username")
                        
                        let signInVC = SignInViewController()
                        signInVC.navigationItem.largeTitleDisplayMode = .always
                        
                        let navVC = UINavigationController(rootViewController: signInVC)
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: nil)
                    }
                }
            }
        }))
        present(ac, animated: true)
    }
    
    @objc private func didReshresh() {
        DispatchQueue.main.async {
            [weak self] in
            self?.headerViewModel = nil
            self?.posts = []
            self?.fetchData()
            self?.collectionView?.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.color = .systemPurple
    }
    
    private func fetchData() {
        let username = user.name
        spinner.startAnimating()
        self.headerViewModel = ProfileHeaderViewModel(profileImageUrl: nil, name: username)
        let group = DispatchGroup()
        // Profile picture
        group.enter()
        StorageManager.shared.getProfilePictureUrl(for: username) { [weak self] url in
            defer {
                group.leave()
            }
            guard let profileImageUrl = url
            else {
                print("Could not get profile picture from storage")
                return
            }

            self?.headerViewModel = ProfileHeaderViewModel(profileImageUrl: profileImageUrl, name: username)
        }
        // Posts
        group.enter()
        DataBaseManager.shared.getPosts(username: username) { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let posts):
                print("Profile controller: \(username)")
                self?.posts = posts
            case .failure(let error):
                print(error)
                break
            }
        }
        group.notify(queue: .main) {
            self.collectionView?.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    private func configureCollectionView(){
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ ->
            NSCollectionLayoutSection? in
            
            // 1. Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Set spacing between items
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            // 2. Horizontal Group
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.33))
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, repeatingSubitem: item, count: 2)
            
            // 3. Vertical Group
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [horizontalGroup])
            
            // 4. Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.5)),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            
            return section
        })
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            ProfileHeaderCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ProfileHeaderCollectionViewCell.identifier
        )
        collectionView.register(
            PostCollectionViewCell.self,
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.refreshControl = self.refreshControl
        self.collectionView = collectionView
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PostCollectionViewCell.identifier,
            for: indexPath
        ) as? PostCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileHeaderCollectionViewCell.identifier,
                for: indexPath
              ) as? ProfileHeaderCollectionViewCell else {
            return UICollectionReusableView()
        }
        if let viewModel = headerViewModel {
            headerView.configure(with: viewModel)
        }
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let vc = PostDetailViewController(post: post, owner: user.name)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: ProfileHeaderCollectionViewCellDelegate {
    func profileHeaderCollectionViewCellDidTapProfilePicture(_ header: ProfileHeaderCollectionViewCell) {
        
        guard isCurrentUser else {
            print("it is not the current user")
            return
        }

        let ac = UIAlertController(title: "Change Profile Picture", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            // Change to new PHPicker
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .camera
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let configuration = PHPickerConfiguration()
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        present(ac, animated: true)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            print("Email not found in UserDefaults")
            return
        }
        // Get the first item provider from the results, the configuration only allowed one image to be selected
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let selectedImage = image as? UIImage {
                    StorageManager.shared.uploadProfilePicture(username: username, data: selectedImage.pngData()) { [weak self] success in
                        if success {
                            self?.headerViewModel = nil
                            self?.posts = []
                            self?.fetchData()
                            print("image uploaded to the storage")
                        }
                    }
                }
            }
        } else {
            print("No item provider found or item provider can't load UIImage")
            return
        }
    }
}


