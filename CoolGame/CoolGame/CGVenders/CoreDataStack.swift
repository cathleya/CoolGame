//
//  CoreDataStack.swift
//  CoolGame
//
//  Created by herry on 06/03/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    var context:NSManagedObjectContext!
    
    // MARK: - 单例的声明
    static let share:CoreDataStack = {
        
        return CoreDataStack()
    }()
    
    
    override init() {

        let modelURL = Bundle.main.url(forResource: "CoolGameModel", withExtension: "momd")!
        let model:NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
        let coordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        
        
        let manager = FileManager.default
        let urls = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let documentsURL = urls.first!
        let storeURL = documentsURL.appendingPathComponent("CoolGameModel")
        
        DBLog(storeURL)
        
        let store:NSPersistentStore = (try! coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil))
        
        DBLog(store)
        
    }
    
    
    // MARK: - Function
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("save failed... ")
            }
        }
    }
    
    // MARK: - CRUD
    func insert(_ entity:String,_ dict:[String:Any]) {
        let object = NSEntityDescription.insertNewObject(forEntityName: entity, into: context!)
        for (key,value) in dict {
            object.setValue(value, forKey: key)
        }
        context.insert(object)
        saveContext()
    }
    
    
    func delete(_ entity:String,_ field:String) {
        
        let request = NSFetchRequest<NSManagedObject>.init()
        request.entity = NSEntityDescription.entity(forEntityName: entity, in: context!)
        request.predicate = NSPredicate.init(format: field)
        
        let objectArr = try? context?.fetch(request)
        
        for object in objectArr!! {
            context?.delete(object)
        }
        
        saveContext()
        
    }
    
    func update(_ entity:String,_ field:String,_ dict:[String:Any]) {

        let request = NSFetchRequest<NSManagedObject>.init()
        request.entity = NSEntityDescription.entity(forEntityName: entity, in: context!)
        request.predicate = NSPredicate(format:field)
        
        let objectArr = try?context?.fetch(request)
        
        for object in objectArr!! {
            for (key,value) in dict {
                object.setValue(value, forKey: key)
            }
        }
        
        saveContext()
        
    }
    
    
    func query(_ entity:String,_ field:String) -> [Any]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format: field)
        request.resultType = .dictionaryResultType
        return try!context?.fetch(request)
    }
    
    
    func querypages(_ entity:String,_ field:String,_ currentPage:Int)->[Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format: field)
        request.resultType = .dictionaryResultType
        request.fetchLimit = 5
        request.fetchOffset = currentPage*5
        return try!context?.fetch(request)
    }
    
    func statistics(_ entity:String,_ field:String)->Int32{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format: field)
        request.resultType = .countResultType
        let entries = try? context.fetch(request)
        return (entries!.first as AnyObject).int32Value
        
    }
    
    func average(_ entity:String,_ field:String) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.resultType = .dictionaryResultType

        let description = NSExpressionDescription()
        description.name = "AverageScore"
        let args = [NSExpression(forKeyPath:field)]
        description.expression = NSExpression(forFunction: "average:", arguments: args)
        description.expressionResultType = .floatAttributeType
        
        request.propertiesToFetch = [description]
        
        let entries = try!context?.fetch(request)
        let result = entries?.first! as! NSDictionary
        let averageScore = result["AverageScore"]
        
        print("Average:\(averageScore) ...")

    }
    
    
    
    

}
