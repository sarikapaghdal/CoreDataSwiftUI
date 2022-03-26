//
//  Employee+CoreDataProperties.swift
//  CoreDataIntro
//
//  Created by Sarika on 25.03.22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var company: Company?

    public var unwrappedName : String {
        name ?? "Unknown name"
    }
}

extension Employee : Identifiable {

}
