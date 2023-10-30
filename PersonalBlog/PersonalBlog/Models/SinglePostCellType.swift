//
//  SinglePostCellType.swift
//  PersonalBlog
//
//  Created by dnlab on 10/30/23.
//

import Foundation

enum PostDetailCellType {
    case header(viewModel: PostDetailHeaderCellViewModel)
    case textBody(viewModel: PostDetailTextBodyCellViewModel)
    case footer(viewModel: PostDetailFooterCellViewModel)
}
