//
//  ProfileHeaderCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/23.
//

import UIKit
protocol ProfileHeaderCollectionViewCellDelegate: AnyObject {
    func profileHeaderCollectionViewCellDidTapProfilePicture(_ header: ProfileHeaderCollectionViewCell)
}

class ProfileHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileHeaderCollectionViewCell"
    
    weak var delegate: ProfileHeaderCollectionViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let emailLable: UILabel = {
        let label = UILabel()
        label.text = "UserEmail@mail.org"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(emailLable)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        profileImageView.addGestureRecognizer(tap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapProfileImage() {
        delegate?.profileHeaderCollectionViewCellDidTapProfilePicture(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = width/3
        profileImageView.frame = CGRect(x: (width-imageSize)/2, y: 20, width: imageSize, height: imageSize)
        profileImageView.layer.cornerRadius = imageSize/2
        
        emailLable.frame = CGRect(
            x: 0,
            y: profileImageView.bottom+10,
            width: width,
            height: 20
        )
    }
    
    func configure(email: String, image: UIImage?) {
        profileImageView.image = image
        emailLable.text = email
    }
    

    
}
