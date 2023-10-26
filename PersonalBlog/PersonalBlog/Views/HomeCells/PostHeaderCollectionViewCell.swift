//
//  PostHeaderCollectionViewCell.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//

import UIKit

class PostHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostHeaderCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
