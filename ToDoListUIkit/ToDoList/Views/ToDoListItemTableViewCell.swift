//
//  ToDoListItemTableViewCell.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/12.
//

import UIKit

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    
    private var isDone = false
    
    private var viewModel: ToDoListItem?
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
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
            width: contentView.width,
            height: contentView.height-dateLabel.height-2
        )
        
        dateLabel.frame = CGRect(
            x: 10,
            y: contentView.height-dateLabel.height-2,
            width: contentView.width,
            height: dateLabel.height
        )
    }
    
    public func configure(with viewModel: ToDoListItem) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = String(viewModel.dueDate)
    }
    
}
