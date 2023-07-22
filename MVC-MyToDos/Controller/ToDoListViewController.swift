//
//  ToDoListViewController.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class ToDoListViewController: UIViewController {
	private var todoListView = ToDoListView()
	private var toDosListModel: ToDosListModel!
	private var toDoService: ToDoServiceProtocol!
	private var toDosListService: ToDosListServiceProtocol!
	
	init(toDosListModel: ToDosListModel, toDoService: ToDoServiceProtocol, toDosListService: ToDosListServiceProtocol) {
		super.init(nibName: nil, bundle: nil)
		self.toDosListModel = toDosListModel
		self.toDoService = toDoService
		self.toDosListService = toDosListService
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func loadView() {
		super.loadView()
		navigationController?.navigationBar.isHidden = true
		setupToDoListView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(self,
																					 selector: #selector(contextObjectsDidChange),
																					 name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
																					 object: CoreDataManager.shared.mainContext)
		todoListView.setToDosList(toDosListModel)
	}
	
	private func setupToDoListView() {
		todoListView.delegate = self
		self.view = todoListView
	}
	
	
	private func updateToDoList() {
		guard let list = toDosListService.fetchListWithId(toDosListModel.id) else { return }
		toDosListModel = list
		todoListView.setToDosList(list)
	}
	
	@objc func contextObjectsDidChange() {
		updateToDoList()
	}
	
}

extension ToDoListViewController: ToDoListViewDelegate {
	func addToDoAction() {
		let addToDoViewController = AddToDoViewController(toDosListModel: toDosListModel, toDoService: toDoService)
		addToDoViewController.modalPresentationStyle = .pageSheet
		present(addToDoViewController, animated: true)
	}
	func updateToDo(_ todo: ToDoModel) {
		toDoService.updateToDo(todo)
	}
	func deleteToDo(_ todo: ToDoModel) {
		toDoService.deleteToDo(todo)
	}
}


extension ToDoListViewController: BackButtonDelegate {
	
	func navigateBack() {
		navigationController?.popViewController(animated: true)
	}
}
