//
//  EntityModelMapProtocol.swift
//  MVC-MyToDos
//
//  Created by Anderson  on 2023/7/20.
//

import Foundation
import CoreData

protocol EntityModelMapProtocol {
	associatedtype EntityType: NSManagedObject
	func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
	static func mapFromEntity(_ entity: EntityType) -> Self
}
