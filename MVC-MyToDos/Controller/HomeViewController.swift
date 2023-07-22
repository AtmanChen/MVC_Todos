//
//  HomeViewController.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class HomeViewController: UIViewController {
	private var homeView = HomeView()
	private var toDosListService: ToDosListServiceProtocol!
	private var toDoService: ToDoServiceProtocol!
	init(toDosListService: ToDosListServiceProtocol, toDoService: ToDoServiceProtocol) {
		self.toDosListService = toDosListService
		self.toDoService = toDoService
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func loadView() {
		super.loadView()
		setupHomeView()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self,
																					 selector: #selector(contextObjectsDidChange),
																					 name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
																					 object: CoreDataManager.shared.mainContext)
	}
	private func setupHomeView() {
		homeView.delegate = self
		fetchToDosLists()
		self.view = homeView
	}
	
}

extension HomeViewController {
	func fetchToDosLists() {
		let lists = toDosListService.fetchList()
		homeView.setToDosLists(lists)
	}
	@objc func contextObjectsDidChange() {
		fetchToDosLists()
	}
}

extension HomeViewController: HomeViewDelegate {
	func addListAction() {
		let addListViewController = AddListViewController(toDosListService: toDosListService)
		navigationController?.pushViewController(addListViewController, animated: true)
	}
	func selectedList(_ list: ToDosListModel) {
		let todoViewController = ToDoListViewController(toDosListModel: list, toDoService: toDoService, toDosListService: toDosListService)
		navigationController?.pushViewController(todoViewController, animated: true)
	}
	func deleteList(_ list: ToDosListModel) {
		toDosListService.deleteList(list)
	}
}
