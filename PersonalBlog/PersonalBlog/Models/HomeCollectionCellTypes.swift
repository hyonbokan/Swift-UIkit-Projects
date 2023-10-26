//
//  HomeViewCellTypes.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/25.
//

import Foundation

enum HomeCollectionCellTypes {
    case header(viewModel: PostHeaderCollectionViewCellViewModel)
    case body(viewModel: PostBodyCollectionViewCellViewModel)
    case actions(viewModel: PostDateTimeLikesCollectionViewCellViewModel)
}
