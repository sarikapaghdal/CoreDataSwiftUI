//
//  Company+CoreDataProperties.swift
//  CoreDataIntro
//
//  Created by Sarika on 25.03.22.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var employee: NSSet?

    public var unwrappedName : String {
        name ?? "Unknown name"
    }
    
    public var employeesArray: [Employee] {
           let employeeSet = employee as? Set<Employee> ?? []
           
           return employeeSet.sorted {
               $0.unwrappedName < $1.unwrappedName
           }
    }
}

// MARK: Generated accessors for employee
extension Company {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

extension Company : Identifiable { //used in foreach loop

}
