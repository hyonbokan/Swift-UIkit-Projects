//
//  PayWallViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class PayWallViewController: UIViewController {
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "crown.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 80))
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.backgroundColor = .systemPurple
        return imageView
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Join the Premium subscription to have access to unlimited number of articles and posts."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
//        label.backgroundColor = .green
        return label
    }()
    
    private let pricing: UILabel = {
        let label = UILabel()
        label.text = "$4.99 / month"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.textColor = .label
//        label.backgroundColor = .blue
        return label
    }()
    // Call to action Buttons
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
//        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    private let termsView: UITextView = {
        let textView = UITextView()
        textView.text = "This is an auto-renewable subscription. It will be charged to your iTunes account before each pay period. You can cancel anytime by going into your Settings > Subscriptions. Restore purchases if previously subscribed."
        textView.isEditable = true
        textView.textAlignment = .center
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Premium Account"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        addSubviews()
        subscribeButton.addTarget(self, action: #selector(didTapSubscribe), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSubscribe() {
        IAPManager.shared.subscribe { [weak self] result in
            DispatchQueue.main.async {
                if result {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.errorAlert(title: "Error", message: "Sorry! Subscription failed.")
                }
            }
        }
    }
    
    @objc private func didTapRestore() {
        IAPManager.shared.subscribe { [weak self] result in
            DispatchQueue.main.async {
                if result {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.errorAlert(title: "Error", message: "Sorry! We could not restore your subscription.")
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerImageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width/1.5
        )
        
        infoLabel.frame = CGRect(
            x: 0,
            y: headerImageView.bottom,
            width: view.width,
            height: view.height/5
        )
        pricing.frame = CGRect(
            x: 0,
            y: infoLabel.bottom,
            width: view.width,
            height: 30
        )
        subscribeButton.frame = CGRect(
            x: 35,
            y: pricing.bottom+30,
            width: view.width-70,
            height: 50
        )
        restoreButton.frame = CGRect(
            x: 35,
            y: subscribeButton.bottom+10,
            width: view.width-70,
            height: 50
        )
        termsView.frame = CGRect(
            x: 0,
            y: view.height - 100,
            width: view.width,
            height: 100
        )
    }
    
    private func addSubviews() {
        view.addSubview(headerImageView)
        view.addSubview(infoLabel)
        view.addSubview(pricing)
        view.addSubview(subscribeButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
    }
    
    private func errorAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(ac, animated: true)
    }
}
