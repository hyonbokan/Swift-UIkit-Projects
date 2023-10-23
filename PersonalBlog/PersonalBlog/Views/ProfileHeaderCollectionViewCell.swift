//
//  ProfileHeaderCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/23.
//

import UIKit

class ProfileHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileHeaderCollectionViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    private let emailLable: UILabel = {
        let label = UILabel()
        label.text = "Useremail@mail.org"
        label.textAlignment = .center
//        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(emailLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
