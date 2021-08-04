//
//  Feedings+CoreDataProperties.swift
//  Nutby
//
//  Created by Diren Akgöz on 27.07.21.
//
//

import Foundation
import CoreData


extension Feedings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feedings> {
        return NSFetchRequest<Feedings>(entityName: "Feedings")
    }

    @NSManaged public var milliliter: Float
    @NSManaged public var time: Date?
    @NSManaged public var baby: Babies?

}

extension Feedings : Identifiable {

}
