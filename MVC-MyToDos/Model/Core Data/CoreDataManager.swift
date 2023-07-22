//
//  CoreDataManager.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//

import Foundation
import CoreData

class CoreDataManager {
	static let shared = CoreDataManager()
	init() {}
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "ToDoList")
		container.loadPersistentStores { _, error in
			if let error {
				fatalError("Unable to load persistent stores: \(error)")
			}
		}
		return container
	}()
	lazy var mainContext: NSManagedObjectContext = {
		persistentContainer.viewContext
	}()
	func saveContext() {
		saveContext(mainContext)
	}
	func saveContext(_ context: NSManagedObjectContext) {
		if context.parent == mainContext {
			saveDerivedContext(context)
			return
		}
		context.perform {
			do {
				try context.save()
			} catch let error as NSError {
				fatalError("Error: \(error.localizedDescription)")
			}
		}
	}
	func saveDerivedContext(_ context: NSManagedObjectContext) {
		context.perform { [self] in
			do {
				try context.save()
			} catch let error as NSError {
				fatalError("Error: \(error.localizedDescription)")
			}
			saveContext(mainContext)
		}
	}
}
