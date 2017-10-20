//
//  ToDos.swift
//  StuffToDO
//
//  Created by Couto on 10/20/17.
//  Copyright © 2017 coutocode. All rights reserved.
//


import Foundation
import CoreData

extension ToDos {

    @NSManaged var todoItem: String?
    @NSManaged var dueDate: NSDate?
    @NSManaged var complete: NSNumber?

}
