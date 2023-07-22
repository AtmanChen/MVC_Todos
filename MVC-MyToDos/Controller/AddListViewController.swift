//
//  AddListViewController.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import UIKit

class AddListViewController: UIViewController {
	
	private var addListView = AddListView()
	private var toDosListService: ToDosListServiceProtocol!
	
	init(toDosListService: ToDosListServiceProtocol) {
		super.init(nibName: nil, bundle: nil)
		self.toDosListService = toDosListService
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	override func loadView() {
		super.loadView()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = .white
		setupAddListView()
	}
	
	private func setupAddListView() {
		addListView.delegate = self
		self.view = addListView
	}
	
	
	private func backToHome() {
		navigationController?.popViewController(animated: true)
	}
	
}

extension AddListViewController: AddListViewDelegate {
	
	func addList(_ list: ToDosListModel) {
		toDosListService.saveToDosList(list)
		backToHome()
	}
}


extension AddListViewController: BackButtonDelegate {
	
	func navigateBack() {
		backToHome()
	}
}
