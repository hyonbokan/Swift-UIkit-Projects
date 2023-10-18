//
//  AirbnbListingCollectionViewCell.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/18.
//

import UIKit

class AirbnbListingCollectionViewCell: UICollectionViewCell {
    static let identifier = "AirbnbListingCollectionViewCell"
    
    private let listringImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "sun.dust.fill")
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let listingTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let rate: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.textAlignment = .center
        label.text = "Rate"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let listingDescription: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.textAlignment = .left
        label.text = "listingDescription"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let summary: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.textAlignment = .left
        label.text = "summary"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let rules: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.textAlignment = .left
        label.text = "rules"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let space: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.textAlignment = .left
        label.text = "space"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let aboutHost: UIView = {
        let hostView = UIView()
        hostView.backgroundColor = .green
        return hostView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(listringImage)
        contentView.addSubview(listingTitle)
        contentView.addSubview(listingDescription)
        contentView.addSubview(rate)
        contentView.addSubview(summary)
        contentView.addSubview(rules)
        contentView.addSubview(space)
        contentView.addSubview(aboutHost)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 30
        let xPosition: CGFloat = 10
        let imageSize: CGFloat = contentView.width
        listringImage.frame = CGRect(
            x: 0,
            y: safeAreaInsets.top,
            width: imageSize,
            height: imageSize
        )
        
        listingTitle.frame = CGRect(
            x: 0,
            y: listringImage.bottom+padding,
            width: contentView.width,
            height: 30
        )
        
        rate.frame = CGRect(
            x: 0,
            y: listingTitle.bottom+padding,
            width: contentView.width,
            height: 30
        )
        
        let maxLabelSize: CGSize = CGSize(width: contentView.width, height: .infinity)
        let requiredSize: CGSize = listingDescription.sizeThatFits(maxLabelSize)
        
        listingDescription.frame = CGRect(
            x: xPosition,
            y: rate.bottom+padding,
            width: contentView.width,
            height: requiredSize.height
        )
        
        summary.frame = CGRect(
            x: xPosition,
            y: listingDescription.bottom+padding,
            width: contentView.width,
            height: requiredSize.height
        )
        
        rules.frame = CGRect(
            x: xPosition,
            y: summary.bottom+padding,
            width: contentView.width,
            height: requiredSize.height
        )
        
        space.frame = CGRect(
            x: xPosition,
            y: rules.bottom+padding,
            width: contentView.width,
            height: requiredSize.height
        )
        
        aboutHost.frame = CGRect(
            x: 0,
            y: space.bottom+padding,
            width: contentView.width,
            height: 50
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listringImage.image = nil
        listingTitle.text = nil
        listingDescription.text = nil
        rate.text = nil
        summary.text = nil
        rules.text = nil
        space.text = nil
        aboutHost.isHidden = true
    }
}
