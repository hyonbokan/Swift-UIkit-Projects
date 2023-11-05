//
//  PostDetailFooterTableViewCell.swift
//  PersonalBlog
//
//  Created by Michael Kan on 2023/10/30.
//
import SDWebImage
import UIKit
protocol PostDetailFooterTableViewCellDelegate: AnyObject {
    func postDetailFooterTableViewCellDidTapUserImage(_ cell: PostDetailFooterTableViewCell)
}
class PostDetailFooterTableViewCell: UITableViewCell {

    static let identifier = "PostDetailFooterTableViewCell"
    
    weak var delegate: PostDetailFooterTableViewCellDelegate?
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
//    private let emailLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .light)
//        label.textAlignment = .left
//        label.textColor = .label
//        return label
//    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .tertiaryLabel
        addSubview(dateLabel)
        addSubview(profileImage)
        addSubview(usernameLabel)
//        addSubview(emailLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapUserImage))
        profileImage.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        usernameLabel.text = nil
        profileImage.image = nil
//        emailLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profileImageSize: CGFloat = contentView.width/7
        profileImage.frame = CGRect(x: 10, y: contentView.safeAreaInsets.top+5, width: profileImageSize, height: profileImageSize)
        profileImage.layer.cornerRadius = profileImageSize / 2
        
        usernameLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        usernameLabel.frame = CGRect(x: profileImage.right+5, y: (contentView.height-dateLabel.height-usernameLabel.height-10) / 2, width: usernameLabel.width, height: usernameLabel.height)
        
//        emailLabel.frame = CGRect(x: profileImage.right+5, y: usernameLabel.bottom+3, width: usernameLabel.width, height: usernameLabel.height)
        
        dateLabel.frame = CGRect(x: 10, y: profileImage.bottom+5, width: dateLabel.width, height: dateLabel.height)
        
    }
    
    @objc private func didTapUserImage() {
        delegate?.postDetailFooterTableViewCellDidTapUserImage(self)
    }
    
    func configure(with viewModel: PostDetailCellViewModel) {
        profileImage.sd_setImage(with: viewModel.profilePictureUrl, completed: nil)
        usernameLabel.text = viewModel.username
//        emailLabel.text = viewModel.userEmail
        let date = viewModel.date
        dateLabel.text = .date(from: date)
    }

}
