//
//  PostDetailBodyTableViewCell.swift
//  PersonalBlog
//
//  Created by Michael Kan on 2023/10/30.
//

import UIKit

class PostDetailBodyTableViewCell: UITableViewCell {

    static let identifier = "PostDetailBodyTableViewCell"
    
    private var viewModel: PostDetailTextBodyCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = contentView.bounds
    }

}
