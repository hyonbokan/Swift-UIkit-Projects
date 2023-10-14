//
//  NewItemViewController.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/12.
//

import UIKit

class NewItemViewController: UIViewController {
    
    var completion: (() -> Void)?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(datePicker)
        view.addSubview(titleTextField)
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleTextField.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top+30,
            width: view.width-20,
            height: 40
        )
        datePicker.frame = CGRect(
            x: 0,
            y: titleTextField.bottom+10,
            width: view.width,
            height: view.height/2+20
        )
        
        let buttonSize = CGSize(width: view.width - 50, height: 50)
        let buttonX = (view.width - buttonSize.width) / 2

        saveButton.frame = CGRect(
            x: buttonX,
            y: datePicker.bottom + 30,
            width: buttonSize.width,
            height: buttonSize.height
        )
    }
    
    @objc private func didTapSave() {
        let newId = UUID().uuidString
        // guard conditions to ensure that there is title, and correct date selected
        let dueDate = datePicker.date.timeIntervalSince1970
        guard let title = titleTextField.text,
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              dueDate >= Date().addingTimeInterval(-86400).timeIntervalSince1970
        else {
            let ac = UIAlertController(title: "Error", message: "Please input the title and correct date", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Dismiss", style: .default))
            present(ac, animated: true)
            return
        }
        
        let newItem = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        DatabaseManager.shared.saveItem(item: newItem, itemId: newId) { [weak self] result in
            guard result else {
                print("Could not post to DB")
                return
            }
            DispatchQueue.main.async {
                self?.completion?()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
