//
//  DiaperChange+CoreDataProperties.swift
//  Nutby
//
//  Created by Diren Akgöz on 27.07.21.
//
//

import Foundation
import CoreData


extension DiaperChange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaperChange> {
        return NSFetchRequest<DiaperChange>(entityName: "DiaperChange")
    }

    @NSManaged public var feces: Bool
    @NSManaged public var time: Date?
    @NSManaged public var urine: Bool
    @NSManaged public var baby: Babies?

}

extension DiaperChange : Identifiable {

}
