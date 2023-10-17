//
//  AirbnbListingViewController.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/17.
//

import UIKit

class AirbnbDetailViewController: UIViewController {
    // We could also use custom collection cells for it
    private let listringImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "sun.dust.fill")
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        view.addSubview(listringImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = view.width
        listringImage.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: imageSize,
            height: imageSize
        )
    }
}
