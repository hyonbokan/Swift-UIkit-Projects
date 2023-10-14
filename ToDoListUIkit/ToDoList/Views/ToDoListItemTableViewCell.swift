//
//  ToDoListItemTableViewCell.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/12.
//

import UIKit

protocol ToDoListItemTableViewCellDelegate: AnyObject {
    func toDoListItemTableViewCell(_ cell: ToDoListItemTableViewCell)
}

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    
    private var isDone = false
    
    var viewModel: ToDoListItem?
    
    weak var delegate: ToDoListItemTableViewCellDelegate?


    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Item title"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Date"
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(checkButton)
        
        checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        titleLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width - 40,
            height: contentView.height-dateLabel.height-2
        )
        
        dateLabel.frame = CGRect(
            x: 10,
            y: contentView.height-dateLabel.height-2,
            width: contentView.width - 40,
            height: dateLabel.height
        )
        let buttonSize: CGFloat = 20
        checkButton.frame = CGRect(
            x: contentView.width - buttonSize - 10,
            y: (contentView.height - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize
        )
    }
    
    @objc private func didTapCheckButton() {
        guard let viewModel = viewModel else { return }
        delegate?.toDoListItemTableViewCell(self)
    }
    
    public func configure(with viewModel: ToDoListItem) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = String(Date(timeIntervalSince1970: viewModel.dueDate).formatted(date: .abbreviated, time: .shortened))
        
        let imageName = viewModel.isDone ? "checkmark.circle.fill" : "circle"
        checkButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
