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
    
    private let headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        addSubview(headerImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerImage.frame = contentView.bounds
    }
    
    func configure(with viewModel: PostDetailHeaderCellViewModel) {
        headerImage.sd_setImage(with: viewModel.postImage, completed: nil)
    }
}
