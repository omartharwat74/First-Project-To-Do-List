//
//  TodoStorage.swift
//  First Project To Do List
//
//  Created by Omar Tharwat on 3/21/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class TodoStorage {
    
 static  func storeTodo(todo:ArrayTodos)  {
           guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
           let managedContext = appdelegate.persistentContainer.viewContext
           guard let todoEntity = NSEntityDescription.entity(forEntityName: "Todo", in: managedContext) else { return  }
           let todoObject = NSManagedObject.init(entity: todoEntity, insertInto: managedContext)
           todoObject.setValue(todo.Content, forKey: "content")
           todoObject.setValue(todo.details, forKey: "details")
           if let image = todo.image {
               let imageData = image.jpegData(compressionQuality: 1)
               todoObject.setValue(imageData, forKey: "image")
               
               
           }
           do {
              try managedContext.save()
               print("Success")
           }
           catch{
               print("Error")
           }
       }
   static func updateTodo (todo:ArrayTodos,index:Int){
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Todo")
           do {
              let result =   try context.fetch(fetchRequest) as! [NSManagedObject]
               result[index].setValue(todo.Content, forKey:"content")
               result[index].setValue(todo.details, forKey: "details")
               if let image = todo.image {
                   let imageData = image.jpegData(compressionQuality: 1)
                   result[index].setValue(imageData, forKey: "image")
               }
               
               
               
                 try context.save()
          
              }catch{
                  print("Error")
              }
       }
  static  func deleteTodo(index:Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
         let context = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Todo")
         do {
            let result =   try context.fetch(fetchRequest) as! [NSManagedObject]
            let todoToDelete = result[index]
            context.delete(todoToDelete)
               try context.save()
        
            }catch{
                print("Error")
            }
        
    }
  static  func getTodos () -> [ArrayTodos] {
           var todos : [ArrayTodos] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return[]}
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Todo")
           do {
           let result =   try context.fetch(fetchRequest) as! [NSManagedObject]
               
               for mangedTodo in result {
                   let content = mangedTodo.value(forKey: "content") as? String
                   let details = mangedTodo.value(forKey: "details") as? String
                   var imageTodo : UIImage? = nil
                   if let imageFromContext = mangedTodo.value(forKey: "image") as? Data {
                        imageTodo = UIImage(data: imageFromContext)
                   }
                   let todo = ArrayTodos(Content: content ?? "" , image: imageTodo, details: details ?? "" )
                   todos.append(todo)
               }
               
               
           }catch{
               print("Error")
           }
           return todos
       }
    
}
