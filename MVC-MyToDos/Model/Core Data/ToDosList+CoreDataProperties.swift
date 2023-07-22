//
//  ToDosList+CoreDataProperties.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//
//

import Foundation
import CoreData


extension ToDosList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDosList> {
        return NSFetchRequest<ToDosList>(entityName: "ToDosList")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var todos: NSSet?

}

// MARK: Generated accessors for todos
extension ToDosList {

    @objc(addTodosObject:)
    @NSManaged public func addToTodos(_ value: ToDo)

    @objc(removeTodosObject:)
    @NSManaged public func removeFromTodos(_ value: ToDo)

    @objc(addTodos:)
    @NSManaged public func addToTodos(_ values: NSSet)

    @objc(removeTodos:)
    @NSManaged public func removeFromTodos(_ values: NSSet)

}

extension ToDosList : Identifiable {

}
