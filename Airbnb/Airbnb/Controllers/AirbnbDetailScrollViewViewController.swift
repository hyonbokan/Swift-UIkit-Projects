//
//  AirbnbListingViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//

import UIKit

class AirbnbDetailScrollViewViewController: UIViewController {
    
    private let listingView = AirbnbListingView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(listingView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // larger value between view.height and listingView.intrinsicContentSize.height to determine contentHeight.
        let contentHeight: CGFloat = max(listingView.intrinsicContentSize.height, view.height)
        scrollView.frame = view.bounds
        listingView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: contentHeight)
        scrollView.contentSize = listingView.bounds.size
    }
    
}
