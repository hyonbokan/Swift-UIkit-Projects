//
//  AirbnbListingViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/18.
//

import UIKit

class AirbnbListingViewController: UIViewController {
    private let model: AirbnbListing
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .orange
        collectionView.register(AirbnbListingCollectionViewCell.self, forCellWithReuseIdentifier: AirbnbListingCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(model: AirbnbListing) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureCollectionView()
        title = model.name
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
//        print(model)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
//    private func configureCollectionView() {
//        let collectionView = UICollectionView(frame: .zero)
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .systemBackground
//        collectionView.register(AirbnbListingCollectionViewCell.self, forCellWithReuseIdentifier: AirbnbListingCollectionViewCell.identifier)
//        self.collectionView = collectionView
//    }

}

extension AirbnbListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirbnbListingCollectionViewCell.identifier, for: indexPath) as? AirbnbListingCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    
}