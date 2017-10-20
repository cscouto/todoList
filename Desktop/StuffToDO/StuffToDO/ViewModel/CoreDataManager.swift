//
//  CoreDataManager.swift
//  StuffToDO
//
//  Created by Couto on 10/20/17.
//  Copyright © 2017 coutocode. All rights reserved.
//


import UIKit
import CoreData

class CoreDataManager: NSObject {

    static func getMangedObject() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getData(entityName:String, predicate:NSPredicate?=nil) -> [NSManagedObject] {
        var resultsManagedObject: [NSManagedObject] = []
        do {
            let managedObject = getMangedObject()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            if(predicate != nil){
                request.predicate = predicate
            }
            
            let results = try managedObject.fetch(request)
            resultsManagedObject = results as! [NSManagedObject]
        }
        catch {
            print("getData: There was an error retrieving data.")
        }
        return resultsManagedObject
    }
    
    static func save(todoItem:String, dueDate:NSDate, complete:Bool){
        let managedObject = getMangedObject()
        let todo = NSEntityDescription.insertNewObject(forEntityName: "ToDos", into: managedObject) as! ToDos
        todo.complete = complete as NSNumber
        todo.dueDate = dueDate
        todo.todoItem = todoItem
        
        do {
            try managedObject.save()
        }
        catch {
            print("save: Error saving.")
        }
    }
    
    static func update(todoItem:ToDos){
        let managedObject = getMangedObject()
        
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDos")
            request.predicate = NSPredicate(format: "todoItem=%@ and dueDate=%@", todoItem.todoItem!, todoItem.dueDate!)
            
            let results = try managedObject.fetch(request)
            let resultSet = results as! [ToDos]
            resultSet[0].complete = todoItem.complete
        }
        catch {
            print("update: Error fetching")
        }
        
        do {
            try managedObject.save()
        }
        catch {
            print("update: Error updating")
        }
    }
}
