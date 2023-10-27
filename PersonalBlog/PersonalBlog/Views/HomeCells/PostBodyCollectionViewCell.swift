//
//  PostBodyCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//

import UIKit

class PostBodyCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostBodyCollectionViewCell"
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        label.backgroundColor = .cyan
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(postImage)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .red
        
        let postImageTap = UITapGestureRecognizer(target: self, action: #selector(didTapBodyElement))
        let titleTap = UITapGestureRecognizer(target: self, action: #selector(didTapBodyElement))
        postImage.addGestureRecognizer(postImageTap)
        titleLabel.addGestureRecognizer(titleTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapBodyElement() {
        print("Body element tapped")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding: CGFloat = 5
        let imageSize: CGFloat = contentView.height-(padding * 2)
        postImage.frame = CGRect(
            x: contentView.width-imageSize-(padding*2),
            y: (contentView.height-imageSize)/2,
            width: imageSize,
            height: imageSize
        )
        titleLabel.frame = CGRect(
            x: padding,
            y: 0,
            width: contentView.width-imageSize-(padding*4),
            height: contentView.height
        )
    }
    
}