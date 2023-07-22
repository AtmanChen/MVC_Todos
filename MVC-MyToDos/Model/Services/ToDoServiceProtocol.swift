//
//  ToDoServiceProtocol.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/21.
//

import Foundation
import CoreData

protocol ToDoServiceProtocol {
	init(coreDataManager: CoreDataManager)
	func saveToDo(_ todo: ToDoModel, in toDoList: ToDosListModel)
	func fetchToDosForList(_ toDosList: ToDosListModel) -> [ToDoModel]
	func updateToDo(_ todo: ToDoModel)
	func deleteToDo(_ todo: ToDoModel)
}

final class ToDoService: ToDoServiceProtocol {
	let context: NSManagedObjectContext
	let coreDataManager: CoreDataManager
	required init(coreDataManager: CoreDataManager = .shared) {
		self.context = coreDataManager.mainContext
		self.coreDataManager = coreDataManager
	}
	func saveToDo(_ todo: ToDoModel, in toDoList: ToDosListModel) {
		do {
			let fetchRequest: NSFetchRequest<ToDosList> = ToDosList.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", toDoList.id)
			guard let list = try context.fetch(fetchRequest).first else {
				return
			}
			let todoEntity = todo.mapToEntityInContext(context)
			list.addToTodos(todoEntity)
			coreDataManager.saveContext(context)
		} catch {
			debugPrint("CoreData Error")
		}
	}
	func fetchToDosForList(_ toDosList: ToDosListModel) -> [ToDoModel] {
		do {
			let fetchRequest: NSFetchRequest<ToDosList> = ToDosList.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", toDosList.id)
			guard let todoEntities = (try context.fetch(fetchRequest).first?.todos) else {
				return []
			}
			return todoEntities.map { ToDoModel.mapFromEntity($0 as! ToDo) }
		} catch {
			debugPrint("CoreData Error")
			return []
		}
	}
	func updateToDo(_ todo: ToDoModel) {
		do {
			let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", todo.id)
			guard let todoEntity = try context.fetch(fetchRequest).first else {
				return
			}
			todoEntity.done = todo.done
			coreDataManager.saveContext(context)
		} catch {
			debugPrint("CoreData Error")
		}
	}
	func deleteToDo(_ todo: ToDoModel) {
		do {
			let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", todo.id)
			let todoEntity = try context.fetch(fetchRequest)
			for entity in todoEntity {
				context.delete(entity)
			}
			coreDataManager.saveContext(context)
		} catch {
			debugPrint("CoreData Error")
		}
	}
}
