//
//  AirbnbListingViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//

import UIKit

class AirbnbDetailScrollViewViewController: UIViewController {
    
    private let model: AirbnbListing
    
    private let listingView = AirbnbListingView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
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
        view.addSubview(scrollView)
        scrollView.addSubview(listingView)
        listingView.configure(with: model)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // larger value between view.height and listingView.intrinsicContentSize.height to determine contentHeight.
        let contentHeight: CGFloat = max(listingView.intrinsicContentSize.height, view.height) + 100.0
        scrollView.frame = view.bounds
        listingView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: contentHeight)
        scrollView.contentSize = listingView.bounds.size
    }
    
}
