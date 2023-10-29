//
//  PostCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/23.
//
import SDWebImage
import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .label
        return imageView
    }()
    
    private let postTitle: UILabel = {
        let label = UILabel()
        label.text = "Post title"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemPurple.cgColor
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(postTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height-40)
        postTitle.frame = CGRect(x: 0, y: imageView.bottom, width: contentView.width, height: 40)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        postTitle.text = nil
    }
    
    func configure(with image: UIImage?, title: String) {
        imageView.image = image
        postTitle.text = title
    }
    
    func configure(with viewModel: BlogPost) {
        imageView.sd_setImage(with: URL(string: viewModel.postUrlString), completed: nil)
        postTitle.text = viewModel.title
    }
}
