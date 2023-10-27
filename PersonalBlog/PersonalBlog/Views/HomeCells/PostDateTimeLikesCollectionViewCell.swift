//
//  PostActionsCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//

import UIKit

class PostDateTimeLikesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostDateTimeLikesCollectionViewCell"
    
    private let timestamp: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    private let likeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        imageView.image?.withTintColor(.label)
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(timestamp)
        contentView.addSubview(likeImage)
        contentView.addSubview(likeCountLabel)
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timestamp.sizeToFit()
        timestamp.frame = CGRect(
            x: 5,
            y: (contentView.height-timestamp.height)/2,
            width: timestamp.width,
            height: timestamp.height
        )
        
        let imageSize: CGFloat = 20
        likeImage.frame = CGRect(
            x: (contentView.width-timestamp.width) + (imageSize*3),
            y: (contentView.height-imageSize)/2,
            width: imageSize,
            height: imageSize
        )
        likeCountLabel.sizeToFit()
        likeCountLabel.frame = CGRect(
            x: likeImage.right+5,
            y: (contentView.height-likeCountLabel.height)/2,
            width: likeCountLabel.width,
            height: likeCountLabel.height
        )
    }
    
    func configure(with viewModel: PostDateTimeLikesCollectionViewCellViewModel) {
        timestamp.text = .date(from: viewModel.date)
        let likeCount = viewModel.likeredBy
        if likeCount.isEmpty {
            likeCountLabel.text = "0"
        } else {
            likeCountLabel.text = "\(likeCount.count)"
        }
        
    }
}
