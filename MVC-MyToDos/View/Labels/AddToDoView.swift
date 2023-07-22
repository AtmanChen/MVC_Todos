//
//  AddToDoView.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

protocol AddToDoViewDelegate: AnyObject {
	func addToDo(_ todo: ToDoModel)
}

class AddToDoView: UIView {
	private(set) var backButton = BackButton()
	private(set) var pageTitle = PageLabel(title: "Add ToDo")
	private(set) var titleLabel = UILabel(frame: .zero)
	private(set) var titleTextfield = UITextField()
	private(set) var iconLabel = UILabel(frame: .zero)
	private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainCoralColor)
	private(set) var addToDoButton = MainButton(title: "Add ToDo", color: .mainCoralColor)
	
	private(set) var toDoModel = ToDoModel()
	
	weak var delegate: AddToDoViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		
		configurePageTitleLabel()
		configureTitleLabel()
		configureTitleTextfield()
		configureIconLabel()
		configureAddToDoButton()
		configureCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AddToDoView {
	func configurePageTitleLabel() {
		addSubview(pageTitle)
		
		NSLayoutConstraint.activate([
			pageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
			pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
			pageTitle.heightAnchor.constraint(equalToConstant: 40)
		])
	}
	
	func configureTitleLabel() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.text = "Title"
		titleLabel.font = .systemFont(ofSize: 21, weight: .light)
		titleLabel.textColor = .grayTextColor
		addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
			titleLabel.heightAnchor.constraint(equalToConstant: 26)
		])
	}
	
	func configureTitleTextfield() {
		titleTextfield.translatesAutoresizingMaskIntoConstraints = false
		titleTextfield.textColor = .grayTextColor
		titleTextfield.attributedPlaceholder = NSAttributedString(
			string: "Add task",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayBackgroundColor]
		)
		addSubview(titleTextfield)
		
		NSLayoutConstraint.activate([
			titleTextfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			titleTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
			titleTextfield.heightAnchor.constraint(equalToConstant: 50),
		])
	}
	
	func configureIconLabel() {
		iconLabel.translatesAutoresizingMaskIntoConstraints = false
		iconLabel.text = "Icon"
		iconLabel.font = .systemFont(ofSize: 21, weight: .light)
		iconLabel.textColor = .grayTextColor
		addSubview(iconLabel)
		
		NSLayoutConstraint.activate([
			iconLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			iconLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
			iconLabel.heightAnchor.constraint(equalToConstant: 26)
		])
	}
	
	func configureAddToDoButton() {
		addToDoButton.addTarget(self, action: #selector(addToDoAction), for: .touchUpInside)
		addSubview(addToDoButton)
		
		NSLayoutConstraint.activate([
			addToDoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			addToDoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
			addToDoButton.widthAnchor.constraint(equalToConstant: 150),
			addToDoButton.heightAnchor.constraint(equalToConstant: 60)
		])
	}
	
	@objc func addToDoAction() {
		guard titleTextfield.hasText else { return }
		
		toDoModel.title = titleTextfield.text
		toDoModel.icon = toDoModel.icon ?? "checkmark.seal.fill"
		toDoModel.done = false
		toDoModel.id = ProcessInfo().globallyUniqueString
		toDoModel.createdAt = Date()
		delegate?.addToDo(toDoModel)
	}
	
	func configureCollectionView() {
		iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
		iconSelectorView.delegate = self
		addSubview(iconSelectorView)
		
		NSLayoutConstraint.activate([
			iconSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			iconSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
			iconSelectorView.bottomAnchor.constraint(equalTo: addToDoButton.topAnchor, constant: -20)
		])
	}
}

extension AddToDoView: IconSelectorViewDelegate {
	func selectedIcon(_ icon: String) {
		toDoModel.icon = icon
	}
}
