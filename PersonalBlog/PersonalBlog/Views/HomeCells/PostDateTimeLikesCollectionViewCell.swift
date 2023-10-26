//
//  PostActionsCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//

import UIKit

class PostDateTimeLikesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostDateTimeLikesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
