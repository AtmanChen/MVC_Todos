//
//  TaskCell.swift
//  MVC-MyToDos
//
//  Created by Raúl Ferrer on 4/4/22.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func updateToDo(_ todo: ToDoModel)
}

class ToDocell: UITableViewCell {
    
    static let reuseId = "ToDoCell"
    
    private(set) var todo: ToDoModel!

    private var container = UIView(frame: .zero)
    private var iconView = UIImageView(frame: .zero)
    private var titleLabel = UILabel(frame: .zero)
    private var taskLabel = UILabel(frame: .zero)
    private var checkButton = ToDoCheckButton(frame: .zero)
   
    weak var delegate: ToDoCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        setContainer()
        setIcon()
        setCheckButton()
        setTitleLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setParametersForTask(_ todo: ToDoModel) {
        self.todo = todo
        
        iconView.image = UIImage(systemName: todo.icon)?
            .withTintColor(.mainCoralColor, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 35.0))
        titleLabel.text = todo.title
        checkButton.setButtonChecked(todo.done)
    }
}

private extension ToDocell {
    
    func setContainer() {
        contentView.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .mainCoralBackgroundColor
        container.layer.cornerRadius = 10
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    func setIcon() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .center
        container.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            iconView.heightAnchor.constraint(equalToConstant: 50),
            iconView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setCheckButton() {
        checkButton.addTarget(self, action: #selector(checkChanged), for: .touchUpInside)
        container.addSubview(checkButton)
    
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    @objc func checkChanged() {
        todo.done.toggle()
        checkButton.setButtonChecked(todo.done)
        delegate?.updateToDo(todo)
    }
    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .darkGray
        titleLabel.font = .systemFont(ofSize: 18, weight: .light)
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byTruncatingTail
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}
