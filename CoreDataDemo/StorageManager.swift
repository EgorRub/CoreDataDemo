//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Егор on 18.08.2021.
//

import Foundation
import CoreData


class StorageManager {
    
    // MARK: - Main
    
    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static let shared = StorageManager()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
    }
    
    // MARK: - Private Funcs
    func fetchData() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        var taskList: [Task] = []
        
        do{
            taskList = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return taskList
    }
    
    func save(_ taskName: String) {
//        guard let entityDiscribtion = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
//        guard let task = NSManagedObject(entity: entityDiscribtion, insertInto: context) as? Task else { return }
//        task.name = taskName
//        taskList.append(task)
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do{
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}



