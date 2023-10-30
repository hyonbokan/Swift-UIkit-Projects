//
//  PostHeaderCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//
import SDWebImage
import UIKit

class PostHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostHeaderCollectionViewCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImage)
        contentView.addSubview(usernameLabel)
        
        let tapUsername = UITapGestureRecognizer(target: self, action: #selector(didTapHeaderElement))
        let tapProfileImage = UITapGestureRecognizer(target: self, action: #selector(didTapHeaderElement))
        usernameLabel.addGestureRecognizer(tapUsername)
        profileImage.addGestureRecognizer(tapProfileImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapHeaderElement() {
        print("Header element tapped")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 4
        let imageSize: CGFloat = contentView.height - (padding*2)
        profileImage.frame = CGRect(
            x: padding,
            y: padding,
            width: imageSize,
            height: imageSize
        )
        profileImage.layer.cornerRadius = imageSize/2
        
        usernameLabel.sizeToFit()
        usernameLabel.frame = CGRect(
            x: profileImage.right+10,
            y: 0,
            width: usernameLabel.width,
            height: contentView.height
        )
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        usernameLabel.text = nil
    }
    
    func configure(with viewModel: PostHeaderCollectionViewCellViewModel) {
        usernameLabel.text = viewModel.username
        profileImage.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
    }
}
