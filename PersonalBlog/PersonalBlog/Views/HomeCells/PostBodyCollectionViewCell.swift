//
//  PostBodyCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//
import SDWebImage
import UIKit

class PostBodyCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostBodyCollectionViewCell"
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
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
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(postImage)
        contentView.addSubview(titleLabel)
        
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
        let imageSize: CGFloat = contentView.height-(padding * 4)
        postImage.frame = CGRect(
            x: contentView.width-imageSize-(padding*8),
            y: (contentView.height-imageSize)/2,
            width: imageSize,
            height: imageSize
        )
        titleLabel.frame = CGRect(
            x: padding,
            y: 0,
            width: contentView.width-imageSize-70,
            height: contentView.height
        )
    }
    
    func configure(with viewModel: PostBodyCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        postImage.sd_setImage(with: viewModel.postImage, completed: nil)
    }
}
