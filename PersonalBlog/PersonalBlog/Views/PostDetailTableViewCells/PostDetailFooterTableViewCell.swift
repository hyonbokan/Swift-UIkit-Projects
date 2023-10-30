//
//  PostDetailFooterTableViewCell.swift
//  PersonalBlog
//
//  Created by Michael Kan on 2023/10/30.
//

import UIKit

class PostDetailFooterTableViewCell: UITableViewCell {

    static let identifier = "PostDetailFooterTableViewCell"
    
    private var viewModel: PostDetailFooterCellViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray
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
