//
//  Babies+CoreDataProperties.swift
//  Nutby
//
//  Created by Diren Akgöz on 27.07.21.
//
//

import Foundation
import CoreData


extension Babies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Babies> {
        return NSFetchRequest<Babies>(entityName: "Babies")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var picture: Data?
    @NSManaged public var diaper_change: NSSet?
    @NSManaged public var feeding: NSSet?

}

// MARK: Generated accessors for diaper_change
extension Babies {

    @objc(addDiaper_changeObject:)
    @NSManaged public func addToDiaper_change(_ value: DiaperChange)

    @objc(removeDiaper_changeObject:)
    @NSManaged public func removeFromDiaper_change(_ value: DiaperChange)

    @objc(addDiaper_change:)
    @NSManaged public func addToDiaper_change(_ values: NSSet)

    @objc(removeDiaper_change:)
    @NSManaged public func removeFromDiaper_change(_ values: NSSet)

}

// MARK: Generated accessors for feeding
extension Babies {

    @objc(addFeedingObject:)
    @NSManaged public func addToFeeding(_ value: Feedings)

    @objc(removeFeedingObject:)
    @NSManaged public func removeFromFeeding(_ value: Feedings)

    @objc(addFeeding:)
    @NSManaged public func addToFeeding(_ values: NSSet)

    @objc(removeFeeding:)
    @NSManaged public func removeFromFeeding(_ values: NSSet)

}

extension Babies : Identifiable {

}
