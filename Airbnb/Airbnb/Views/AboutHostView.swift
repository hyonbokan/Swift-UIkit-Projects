//
//  AboutHostView.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/18.
//

import UIKit

class AboutHostView: UIView {
    
    private let header: UILabel = {
        let label = UILabel()
        label.text = "About Your Host"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let hostImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let hostName: UILabel = {
        let label = UILabel()
        label.text = "Host name"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.backgroundColor = .darkGray
        return label
    }()
    
    private let footer: UILabel = {
        let label = UILabel()
        label.text = "footer"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubview(header)
        addSubview(hostImage)
        addSubview(hostName)
        addSubview(footer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        header.frame = CGRect(x: 0, y: 0, width: width, height: 40)
        
        let imageSize: CGFloat = width/5
        hostImage.frame = CGRect(x: (width-imageSize)/2, y: (height-imageSize)/2, width: imageSize, height: imageSize)
        hostImage.layer.cornerRadius = imageSize/2.0
        
        hostName.frame = CGRect(
            x: hostImage.right + 5,
            y: (height-20)/2,
            width: width/2.5,
            height: 20
        )
        let footerYPosition = height - 20 - safeAreaInsets.bottom
        footer.frame = CGRect(x: 0, y: footerYPosition, width: width, height: 20)
    }
    
}
