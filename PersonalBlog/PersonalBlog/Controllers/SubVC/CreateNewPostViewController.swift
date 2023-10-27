//
//  CreateNewPostViewController.swift
//  PersonalBlog
//
//  Created by dnlab on 2023/10/20.
//
import PhotosUI
import UIKit

class CreateNewPostViewController: UIViewController {
    
    var completion: (() -> Void)?
    
    private let photoPickerButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemPurple
        let image = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: UIImage.SymbolConfiguration(pointSize: 70))
        button.setImage(image, for: .normal)
        button.backgroundColor = .secondarySystemBackground
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
        let configuration = PHPickerConfiguration()
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapPost() {
        titleTextView.resignFirstResponder()
        bodyTextView.resignFirstResponder()
        
        var titleText = titleTextView.text ?? ""
        var bodyText = bodyTextView.text ?? ""
        
        if titleText == "Add the title..." {
            titleText = ""
        }
        if bodyText == "Input the text for the body..." {
            bodyText = ""
        }
        // Post ID
        guard let newPostID = createNewPostID(),
        let stringDate = String.date(from: Date()) else {
            return
        }
        guard let image = photoPickerButton.imageView?.image else {
            print("PhotoPickerButton image could not be accessed")
            return
        }
        // Upload post to Storage
        StorageManager.shared.uploadPost(data: image.pngData(), id: newPostID) { newPostUrl in
            guard let url = newPostUrl else {
                print("error: failed to upload")
                return
            }
            // New Post
            let newPost = BlogPost(
                id: newPostID,
                title: titleText,
                postedDate: stringDate,
                body: bodyText,
                postUrlString: url.absoluteString
            )
            
            DataBaseManager.shared.createPost(newPost: newPost) { [weak self] success in
                guard success else {
                    print("Could not upload the new post to the db")
                    return
                }
                DispatchQueue.main.async {
                    self?.completion?()
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
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
    
    private func createNewPostID() -> String? {
        let timeStamp = Date().timeIntervalSince1970
        let randomNumber = Int.random(in: 0...1000)
        guard let username = UserDefaults.standard.string(forKey: "name") else {
            return nil
        }
        
        return "\(username)_\(randomNumber)_\(timeStamp)"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add caption..." {
            textView.text = nil
        }
        
        if textView.text == "Input the text for the body..." {
            textView.text = nil
        }
    }

}

extension CreateNewPostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // Get the first item provider from the results, the configuration only allowed one image to be selected
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                // TODO: Do something with the image or handle the error
                if let selectedImage = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.photoPickerButton.setImage(selectedImage, for: .normal)
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
            return
        }
    }
}
