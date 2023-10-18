//
//  AirbnbListingView.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/18.
//
import SDWebImage
import UIKit

class AirbnbListingView: UIView {
    
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
        label.text = "rate"
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
    
    private let aboutHost: AboutHostView = {
        let hostView = AboutHostView()
        hostView.backgroundColor = .green
        hostView.clipsToBounds = true
        return hostView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(listringImage)
        addSubview(listingTitle)
        addSubview(listingDescription)
        addSubview(rate)
        addSubview(summary)
        addSubview(rules)
        addSubview(space)
        addSubview(aboutHost)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 30
        let xPosition: CGFloat = 10
        let imageSize: CGFloat = width
        listringImage.frame = CGRect(
            x: 0,
            y: safeAreaInsets.top,
            width: imageSize,
            height: imageSize
        )
        
        listingTitle.frame = CGRect(
            x: 0,
            y: listringImage.bottom+padding,
            width: width,
            height: 30
        )
        
        rate.frame = CGRect(
            x: 0,
            y: listingTitle.bottom+padding,
            width: width,
            height: 30
        )
        
        let maxLabelSize: CGSize = CGSize(width: width, height: .infinity)
        let requiredSize: CGSize = listingDescription.sizeThatFits(maxLabelSize)
        
        listingDescription.frame = CGRect(
            x: xPosition,
            y: rate.bottom+padding,
            width: width-20,
            height: requiredSize.height
        )
        
        summary.frame = CGRect(
            x: xPosition,
            y: listingDescription.bottom+padding,
            width: width-20,
            height: requiredSize.height
        )
        
        rules.frame = CGRect(
            x: xPosition,
            y: summary.bottom+padding,
            width: width-20,
            height: requiredSize.height
        )
        
        space.frame = CGRect(
            x: xPosition,
            y: rules.bottom+padding,
            width: width-20,
            height: requiredSize.height
        )
//        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
//        let dynamicSize = aboutHost.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//
//        aboutHost.frame = CGRect(x: 0, y: space.bottom + padding, width: width, height: dynamicSize.height)
        
        aboutHost.frame = CGRect(
            x: 0,
            y: space.bottom+padding,
            width: width,
            height: 150
        )
    }
    
    func configure(with viewModel: AirbnbListing) {
        listringImage.sd_setImage(with: URL(string: viewModel.xl_picture_url ?? ""), completed: nil)
        listingTitle.text = viewModel.name
        rate.text = viewModel.price?.formatted(.currency(code: "USD"))
        listingDescription.text = viewModel.description
        summary.text  = viewModel.summary
        rules.text  = viewModel.house_rules
        space.text  = viewModel.space
//        aboutHost = viewModel.host_name
    }
}
