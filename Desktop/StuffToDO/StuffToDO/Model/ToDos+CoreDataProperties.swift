//
//  ToDos+CoreDataProperties.swift
//  ToDoBot
//
//  Created by Brett Romero on 4/24/16.
//  Copyright © 2016 tester. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDos {

    @NSManaged var todoItem: String?
    @NSManaged var dueDate: NSDate?
    @NSManaged var complete: NSNumber?

}
