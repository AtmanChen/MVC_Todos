//
//  ToDoListView.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

protocol ToDoListViewDelegate {
	func addToDoAction()
	func updateToDo(_ todo: ToDoModel)
	func deleteToDo(_ todo: ToDoModel)
}

class ToDoListView: UIView {
	private(set) var backButton = BackButton(frame: .zero)
	private(set) var pageTitle = PageLabel(frame: .zero)
	private(set) var tableView = UITableView(frame: .zero, style: .grouped)
	private(set) var addTaskButton = MainButton(title: "Add ToDo", color: .mainCoralColor)
	private(set) var emptyState = EmptyStateView(frame: .zero, title: "Press 'Add ToDo' to add your first todo to the list")
	private(set) var todos = [ToDoModel]()
	
	weak var delegate: (ToDoListViewDelegate & BackButtonDelegate)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		
		configureBackButton()
		configurePageTitleLabel()
		configureAddTaskButton()
		configureTableView()
		configureEmptyState()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setToDosList(_ todosList: ToDosListModel) {
		todos = todosList.todos.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending })
		pageTitle.setTitle(todosList.title)
		tableView.reloadData()
		emptyState.isHidden = todos.count > 0
	}
}

private extension ToDoListView {
	
	func configureBackButton() {
		backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
		addSubview(backButton)
		
		NSLayoutConstraint.activate([
			backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
			backButton.heightAnchor.constraint(equalToConstant: 40),
			backButton.widthAnchor.constraint(equalToConstant: 40),
		])
	}
	
	@objc func backAction() {
		delegate?.navigateBack()
	}
	
	func configurePageTitleLabel() {
		addSubview(pageTitle)
		
		NSLayoutConstraint.activate([
			pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
			pageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
			pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
			pageTitle.heightAnchor.constraint(equalToConstant: 40)
		])
	}
	
	func configureAddTaskButton() {
		addTaskButton.addTarget(self, action: #selector(addTaskAction), for: .touchUpInside)
		addSubview(addTaskButton)
		
		NSLayoutConstraint.activate([
			addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
			addTaskButton.widthAnchor.constraint(equalToConstant: 200),
			addTaskButton.heightAnchor.constraint(equalToConstant: 60)
		])
	}
	
	@objc func addTaskAction() {
		delegate?.addToDoAction()
	}
	
	func configureTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
		tableView.separatorColor = .clear
		tableView.bounces = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(ToDocell.self, forCellReuseIdentifier: ToDocell.reuseId)
		addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
			tableView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
		])
	}
	
	func configureEmptyState() {
		addSubview(emptyState)
		
		NSLayoutConstraint.activate([
			emptyState.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20),
			emptyState.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -20),
			emptyState.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
			emptyState.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -40)
		])
	}
}

extension ToDoListView: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ToDocell.reuseId, for: indexPath) as! ToDocell
		cell.setParametersForTask(todos[indexPath.row])
		cell.delegate = self
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let todo = todos[indexPath.row]
			todos.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			delegate?.deleteToDo(todo)
		}
	}
}

extension ToDoListView: ToDoCellDelegate {
	func updateToDo(_ todo: ToDoModel) {
		delegate?.updateToDo(todo)
	}
}
