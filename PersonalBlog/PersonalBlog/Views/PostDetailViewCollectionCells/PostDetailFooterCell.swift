//
//  PostDetailFooterCell.swift
//  PersonalBlog
//
//  Created by dnlab on 10/30/23.
//

import UIKit

class PostDetailFooterCell: UICollectionViewCell {
    static let identifier = "PostDetailFooterCellViewModel"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
