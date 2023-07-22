//
//  ToDosListServiceProtocol.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//

import Foundation
import CoreData

protocol ToDosListServiceProtocol: AnyObject {
	init(coreDataManager: CoreDataManager)
	func saveToDosList(_ list: ToDosListModel)
	func fetchList() -> [ToDosListModel]
	func fetchListWithId(_ id: String) -> ToDosListModel?
	func deleteList(_ list: ToDosListModel)
}

final class ToDosListService: ToDosListServiceProtocol {
	let context: NSManagedObjectContext
	let coreDataManager: CoreDataManager
	required init(coreDataManager: CoreDataManager = .shared) {
		self.context = coreDataManager.mainContext
		self.coreDataManager = coreDataManager
	}
	func saveToDosList(_ list: ToDosListModel) {
		_ = list.mapToEntityInContext(context)
		coreDataManager.saveContext(context)
	}
	func fetchList() -> [ToDosListModel] {
		var lists: [ToDosListModel] = []
		do {
			let fetchRequest: NSFetchRequest<ToDosList> = ToDosList.fetchRequest()
			fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
			let value = try context.fetch(fetchRequest)
			lists = value.map { ToDosListModel.mapFromEntity($0) }
		} catch {
			debugPrint("CoreData Error")
		}
		return lists
	}
	func fetchListWithId(_ id: String) -> ToDosListModel? {
		do {
			let fetchRequest: NSFetchRequest<ToDosList> = ToDosList.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", id)
			let listEntities = try context.fetch(fetchRequest)
			guard let list = listEntities.first else {
				return nil
			}
			return ToDosListModel.mapFromEntity(list)
		} catch {
			debugPrint("CoreData Error")
			return nil
		}
	}
	func deleteList(_ list: ToDosListModel) {
		do {
			let fetchRequest: NSFetchRequest<ToDosList> = ToDosList.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id = %@", list.id)
			let listEntities = try context.fetch(fetchRequest)
			for listEntity in listEntities {
				context.delete(listEntity)
			}
			coreDataManager.saveContext(context)
		} catch {
			debugPrint("CoreData Error")
		}
	}
}
