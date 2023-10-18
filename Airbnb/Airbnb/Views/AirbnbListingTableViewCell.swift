//
//  AirbnbListingTableViewCell.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//

import UIKit

class AirbnbListingTableViewCell: UITableViewCell {
    
    static let identifier = "AirbnbListingTableViewCell"
    
//    private var index = 0
    
    private let listringImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "doc.text.image")
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Listing Title"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
//        label.backgroundColor = .red
        return label
    }()
    
    private let detail: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.text = "Detail"
//        label.backgroundColor = .green
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(title)
        contentView.addSubview(detail)
        contentView.addSubview(listringImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        title.text = nil
        detail.text = nil
        listringImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = 100
        let padding: CGFloat = 10
        let spaceBetweenTitleAndDetail: CGFloat = 5
        let desiredBottomPadding: CGFloat = 10
        
        listringImage.frame = CGRect(
            x: 10,
            y: (contentView.height - imageSize) / 2,
            width: imageSize,
            height: imageSize
        )
        
        title.frame = CGRect(
            x: listringImage.right + padding,
            y: (contentView.height - imageSize) / 2,
            width: contentView.width - listringImage.right - padding,
            height: 30
        )
        
        let detailHeight = contentView.height - title.bottom - spaceBetweenTitleAndDetail - desiredBottomPadding
        detail.frame = CGRect(
            x: listringImage.right + padding,
            y: title.bottom + spaceBetweenTitleAndDetail,
            width: contentView.width - listringImage.right - padding,
            height: detailHeight
        )
    }
    
    func configure(with viewModel: AirbnbListing) {
//        self.index = index
//        listringImage
        title.text = viewModel.name
        detail.text = viewModel.description
    }
}
