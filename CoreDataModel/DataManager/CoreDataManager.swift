//
//  CoreDataManager.swift
//  CoreDataModel
//
//  Created by 宋璞 on 2019/3/29.
//  Copyright © 2019 宋璞. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    /// 单例
    static let shared = CoreDataManager()
    
    private lazy var context : NSManagedObjectContext = {
        /// 使用 NSPersistentContainer 不用创建
        ///     (NSManagedObjectModel),
        ///     (NSPersistentStoreCoordinator),
        ///     (NSManagedObjectContext).
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        /// 使用
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let per = Person()
        
        return context
    }()

    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved erro \(nserror), \(nserror.userInfo)")
        }
    }
    
    /// 增加数据
    func savePersonWith(name: String, age: Int16) {
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.name = name
        person.age = age
        saveContext()
    }
    
    /// 获取所有数据
    func getAllPerson() -> [Person] {
        let fetRequest : NSFetchRequest = Person.fetchRequest()
        do {
            let result: [Person] = try context.fetch(fetRequest)
            return result
        } catch  {
            fatalError()
        }
    }
    
    /// 根据姓名获取数据
    func getPersonWith(name: String) -> [Person] {
        let fetRequest: NSFetchRequest = Person.fetchRequest()
        fetRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result: [Person] = try context.fetch(fetRequest)
            return result
        } catch  {
            fatalError()
        }
    }
    
    /// 根据姓名修改数据
    func changePersonWith(name: String, newName: String, newAge: Int16) {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                person.name = newName
                person.age = newAge
            }
        } catch  {
            fatalError()
        }
        
        saveContext()
    }
    
    /// 根据条件删除数据
    func deleteWith(name: String) {
        let fetRequest: NSFetchRequest = Person.fetchRequest()
        fetRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetRequest)
            for person in result {
                context.delete(person)
            }
        } catch  {
            fatalError()
        }
        saveContext()
    }
    
    /// 删除所所有数据
    func deleteAllPerson() {
        let result = getAllPerson()
        for person in result {
            context.delete(person)
        }
        saveContext()
    }
    
}
