//
//  ToDosListModel.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//

import Foundation
import CoreData

struct ToDosListModel {
	var id: String!
	var title: String!
	var icon: String!
	var todos: [ToDoModel]!
	var createdAt: Date!
}

extension ToDosListModel: EntityModelMapProtocol {
	typealias EntityType = ToDosList
	func mapToEntityInContext(_ context: NSManagedObjectContext) -> ToDosList {
		let toDosList = ToDosList(context: context)
		toDosList.id = self.id
		toDosList.title = self.title
		toDosList.icon = self.icon
		if let todos {
			todos.forEach {
				$0.mapToEntityInContext(context).list = toDosList
			}
		}
		toDosList.createdAt = self.createdAt
		return toDosList
	}
	static func mapFromEntity(_ entity: ToDosList) -> ToDosListModel {
		guard let toDosListed = entity.todos else {
			return ToDosListModel(id: entity.id, title: entity.title, icon: entity.icon, todos: [], createdAt: entity.createdAt)
		}
		var todos: [ToDoModel] = []
		for todo in toDosListed {
			todos.append(ToDoModel.mapFromEntity(todo as! ToDo))
		}
		return ToDosListModel(id: entity.id, title: entity.title, icon: entity.icon, todos: todos, createdAt: entity.createdAt)
	}
}
