//
//  CreateNewPostViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//

import UIKit

class CreateNewPostViewController: UIViewController {
    
    private let photoPickerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemPurple
        let image = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: UIImage.SymbolConfiguration(pointSize: 70))
        button.setImage(image, for: .normal)
        button.backgroundColor = .label
        return button
    }()
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.secondaryLabel.cgColor
        textView.backgroundColor = .secondarySystemBackground
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.isEditable = true
        textView.text = "Add the title..."
        return textView
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.secondaryLabel.cgColor
        textView.backgroundColor = .secondarySystemBackground
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.text = "Input the text for the body..."
        return textView
    }()

    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .label
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemPurple
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(photoPickerButton)
        view.addSubview(titleTextView)
        view.addSubview(bodyTextView)
        view.addSubview(postButton)
        photoPickerButton.addTarget(self, action: #selector(didTapPhotoPicker), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPost), for: .touchUpInside)
    }
    
    @objc private func didTapPhotoPicker() {
        
    }
    
    @objc private func didTapPost() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoPickerButton.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width-120
        )
        titleTextView.frame = CGRect(
            x: 10,
            y: photoPickerButton.bottom+20,
            width: view.width-20,
            height: 40
        )
        
        bodyTextView.frame = CGRect(
            x: 10,
            y: titleTextView.bottom+20,
            width: view.width-20,
            height: 300
        )
        
        let buttonWidth: CGFloat = view.width-30
        
        postButton.frame = CGRect(
            x: (view.width - buttonWidth)/2,
            y: view.height - (view.safeAreaInsets.bottom + 80),
            width: buttonWidth,
            height: 40
        )
    }

}
