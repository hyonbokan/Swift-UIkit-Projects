//
//  LogInHeaderView.swift
//  ToDoList
//
//  Created by Michael Kan on 2023/10/06.
//

import UIKit

class OnboardHeaderView: UIView {
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
//        backgroundView.backgroundColor = .systemPink
        backgroundView.transform = CGAffineTransform(rotationAngle: 15 * .pi / 180)
        return backgroundView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "To Do List"
        title.font = UIFont.systemFont(ofSize: 50, weight: .bold)
//        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "Get Things Done!"
        subtitle.font = UIFont.systemFont(ofSize: 30, weight: .bold)
//        subtitle.textColor = .white
        subtitle.textAlignment = .center
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
//        backgroundColor = .darkGray
        
        addSubview(backgroundView)
        addSubview(title)
        addSubview(subtitle)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundView.frame = CGRect(x: 0, y: -100, width: width, height: 450)

          title.sizeToFit()
          let titleX = (width - title.width) / 2
          let titleY = backgroundView.top + (backgroundView.height / 2) - title.height + 20 // 10 is a buffer space, adjust as needed
          title.frame = CGRect(x: titleX, y: titleY, width: title.width, height: title.height)

          // Set the subtitle's frame
          subtitle.sizeToFit()
          let subtitleX = (width - subtitle.width) / 2
          let subtitleY = title.bottom + 10 // 10 is a buffer space between title and subtitle, adjust as needed
          subtitle.frame = CGRect(x: subtitleX, y: subtitleY, width: subtitle.width, height: subtitle.height)

    }
    
    func configure(backgroundColor: UIColor, titleText: String, subtitleText: String?, titleColor: UIColor, subtitleColor: UIColor) {
        backgroundView.backgroundColor = backgroundColor
        title.text = titleText
        subtitle.text = subtitleText
        title.textColor = titleColor
        subtitle.textColor = subtitleColor
    }
    
}
