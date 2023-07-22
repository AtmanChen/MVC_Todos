//
//  AddToDoViewController.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class AddToDoViewController: UIViewController {
	
	private var addToDoView = AddToDoView()
	private var toDosListModel: ToDosListModel!
	private var toDoService: ToDoServiceProtocol!
	
	init(toDosListModel: ToDosListModel, toDoService: ToDoServiceProtocol) {
		super.init(nibName: nil, bundle: nil)
		self.toDosListModel = toDosListModel
		self.toDoService = toDoService
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = .white
		setupAddToDoView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	private func setupAddToDoView() {
		addToDoView.delegate = self
		self.view = addToDoView
	}
	
}

extension AddToDoViewController: AddToDoViewDelegate {
	func addToDo(_ todo: ToDoModel) {
		toDoService.saveToDo(todo, in: toDosListModel)
		dismiss(animated: true)
	}
}
