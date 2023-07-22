//
//  ToDo+CoreDataProperties.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var done: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var list: ToDosList?

}

extension ToDo : Identifiable {

}
