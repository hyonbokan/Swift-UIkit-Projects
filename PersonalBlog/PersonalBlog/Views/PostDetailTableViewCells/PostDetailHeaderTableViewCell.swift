//
//  PostDetailHeaderTableViewCell.swift
//  PersonalBlog
//
//  Created by Michael Kan on 2023/10/30.
//
import SDWebImage
import UIKit

class PostDetailHeaderTableViewCell: UITableViewCell {
    static let identifier = "PostDetailHeaderTableViewCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        addSubview(headerImage)
        addSubview(profileImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerImage.image = nil
        profileImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileImageSize: CGFloat = contentView.width/7
        profileImage.frame = CGRect(x: 10, y: contentView.safeAreaInsets.top+5, width: profileImageSize, height: profileImageSize)
        profileImage.layer.cornerRadius = profileImageSize / 2
        
        let imageSize: CGFloat = contentView.width/1.5
        headerImage.frame = CGRect(x: (contentView.width-imageSize)/2, y: profileImage.bottom+10 , width: imageSize, height: imageSize)
        

    }
    
    func configure(with viewModel: PostDetailHeaderCellViewModel) {
        profileImage.sd_setImage(with: viewModel.profilePictureUrl, completed: nil)
        headerImage.sd_setImage(with: viewModel.postImage, completed: nil)
    }
}
