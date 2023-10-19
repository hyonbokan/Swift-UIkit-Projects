//
//  AirbnbListingViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//
import SDWebImage
import UIKit

class AirbnbDetailScrollViewViewController: UIViewController {
    
    private let model: AirbnbListing
    
    private let aboutHostView = AboutHostView()
    
    private let listingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let listingTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Title"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let rate: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "rate"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let listingDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "listingDescription"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let summary: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "summary"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let rules: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "rules"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let space: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "space"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    init(model: AirbnbListing) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = model.name
        
        addSubviews()
        configureView(with: model)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        listingImage.frame = CGRect(x: 0, y: scrollView.top, width: view.width, height: view.width)
        

        let padding: CGFloat = 30
        let xPosition: CGFloat = 10
        listingTitle.frame = CGRect(
            x: 0,
            y: listingImage.bottom+padding,
            width: view.width,
            height: 30
        )
        
        rate.frame = CGRect(
            x: 0,
            y: listingTitle.bottom+padding,
            width: view.width,
            height: 30
        )
        
        let maxLabelSize: CGSize = CGSize(width: view.width, height: .infinity)
        let requiredSizeDescription: CGSize = listingDescription.sizeThatFits(maxLabelSize)
        
        listingDescription.frame = CGRect(
            x: xPosition,
            y: rate.bottom+padding,
            width: view.width-20,
            height: requiredSizeDescription.height+20
        )
        let requiredSizeSummary: CGSize = summary.sizeThatFits(maxLabelSize)
        
        summary.frame = CGRect(
            x: xPosition,
            y: listingDescription.bottom+padding,
            width: view.width-20,
            height: requiredSizeSummary.height
        )
        let requiredSizeRules: CGSize = summary.sizeThatFits(maxLabelSize)
        
        rules.frame = CGRect(
            x: xPosition,
            y: summary.bottom+padding,
            width: view.width-20,
            height: requiredSizeRules.height
        )
        
        let requiredSizeSpace: CGSize = summary.sizeThatFits(maxLabelSize)
        
        space.frame = CGRect(
            x: xPosition,
            y: rules.bottom+padding,
            width: view.width-20,
            height: requiredSizeSpace.height
        )
        
        
        
        let aboutHostViewHeight: CGFloat = 200
        aboutHostView.frame = CGRect(x: 0, y: space.bottom+20, width: scrollView.width, height: aboutHostViewHeight)
        
        let totalContentHeight =
            listingImage.frame.height +
            padding +
            listingTitle.frame.height +
            padding +
            rate.frame.height +
            padding +
            listingDescription.frame.height +
            padding +
            summary.frame.height +
            padding +
            rules.frame.height +
            padding +
            space.frame.height +
            padding +
            aboutHostView.frame.height +
            padding
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalContentHeight)
        
    }
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(listingImage)
        scrollView.addSubview(aboutHostView)
        scrollView.addSubview(listingTitle)
        scrollView.addSubview(rate)
        scrollView.addSubview(listingDescription)
        scrollView.addSubview(summary)
        scrollView.addSubview(rules)
        scrollView.addSubview(space)
    }
    
    private func configureView(with viewModel: AirbnbListing) {
        listingImage.sd_setImage(with: URL(string: viewModel.xl_picture_url ?? ""))
        
        listingTitle.text = viewModel.name
        rate.text = ("Rate: \(viewModel.price?.formatted(.currency(code: "USD")) ?? "")")
        listingDescription.text = ("Description: \(viewModel.description ?? "")")
        summary.text  = ("Summary: \(viewModel.summary ?? "")")
        rules.text  = ("Rules: \(viewModel.house_rules ?? "The owner did not specify")")
        space.text  = "Space: \(viewModel.space ?? "")"
        
        aboutHostView.configure(with: viewModel)
    }
}
