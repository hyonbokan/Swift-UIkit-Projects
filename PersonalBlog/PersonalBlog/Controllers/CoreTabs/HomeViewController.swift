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
        button.layer.shadowColor = UIColor.purple.cgColor
        button.layer.shadowOpacity = 1 // higher value -> more visible
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.3
        button.layer.shadowRadius = 10 // higher value -> more blurred
        button.clipsToBounds = false
        return button
    }()
    
    private var collectionView: UICollectionView?
    
    private var cellViewModels = [[HomeCollectionCellTypes]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(createPostButton)
        createPostButton.addTarget(self, action: #selector(didTapCreatePost), for: .touchUpInside)
        
        for i in 1...10 {
            let postDate: [HomeCollectionCellTypes] = [
                .header(
                    viewModel: PostHeaderCollectionViewCellViewModel(
                        username: "user\(i)",
                        profileImageUrl: nil
                    )
                ),
                .body(
                    viewModel: PostBodyCollectionViewCellViewModel(
                        postImage: nil,
                        title: "Post title \(i)"
                    )
                ),
                .actions(
                    viewModel: PostDateTimeLikesCollectionViewCellViewModel(
                        date: Date(),
                        likeredBy: []
                    )
                )
            ]
            cellViewModels.append(postDate)
        }
        
        
        configureCollectionView()
        print(cellViewModels)
        print(cellViewModels.count)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonSize: CGFloat = 55
        createPostButton.frame = CGRect(x: view.width-75, y: view.height-(view.safeAreaInsets.bottom+100), width: buttonSize, height: buttonSize)
        createPostButton.layer.cornerRadius = buttonSize/2
        
        collectionView?.frame = view.bounds
        
        view.bringSubviewToFront(createPostButton)
        
    }
    
    @objc private func didTapCreatePost() {
        // Make sure to update collectionView with vc completion
        let vc = CreateNewPostViewController()
        present(vc, animated: true)
    }
    
    private func createViewModel(
        model: BlogPost,
        email: String,
        completion: @escaping (Bool) -> Void
    ) {
        
        let postDate1: [HomeCollectionCellTypes] = [
            .header(
                viewModel: PostHeaderCollectionViewCellViewModel(
                    username: "user1",
                    profileImageUrl: nil
                )
            ),
            .body(
                viewModel: PostBodyCollectionViewCellViewModel(
                    postImage: nil,
                    title: "Post title"
                )
            ),
            .actions(
                viewModel: PostDateTimeLikesCollectionViewCellViewModel(
                    date: Date(),
                    likeredBy: []
                )
            )
        ]
        
        cellViewModels.append(postDate1)
        completion(true)
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
        
//        collectionView.backgroundColor = .cyan
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
            return cell
        
        case .body(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostBodyCollectionViewCell.identifier,
                for: indexPath
            ) as? PostBodyCollectionViewCell else {
                fatalError()
            }
            return cell
            
        case .actions(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PostDateTimeLikesCollectionViewCell.identifier,
                for: indexPath
            ) as? PostDateTimeLikesCollectionViewCell else {
                fatalError()
            }
            return cell
        }
    }
    
    
}

