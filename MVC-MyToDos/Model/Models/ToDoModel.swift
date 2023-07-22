//
//  ToDoModel.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//

import Foundation
import CoreData

struct ToDoModel {
	var id: String!
	var title: String!
	var icon: String!
	var done: Bool!
	var createdAt: Date!
}

extension ToDoModel: EntityModelMapProtocol {
	typealias EntityType = ToDo
	func mapToEntityInContext(_ context: NSManagedObjectContext) -> ToDo {
		let todo: ToDo = ToDo(context: context)
		todo.id = self.id
		todo.title = self.title
		todo.icon = self.icon
		todo.done = self.done
		todo.createdAt = self.createdAt
		return todo
	}
	static func mapFromEntity(_ entity: ToDo) -> Self {
		ToDoModel(id: entity.id, title: entity.title, icon: entity.icon, done: entity.done, createdAt: entity.createdAt)
	}
}
