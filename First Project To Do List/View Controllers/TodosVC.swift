//
//  TodosVC.swift
//  First Project To Do List
//
//  Created by Omar Tharwat on 3/7/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit
import CoreData
class TodosVC: UIViewController {
    
    var todos:[ArrayTodos] = []
    
    @IBOutlet weak var TodosTv: UITableView!
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        self.todos = TodoStorage.getTodos()
        
        super.viewDidLoad()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddTodoF), name: NSNotification.Name(rawValue: "AddTodo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(currenttodoEditet), name: NSNotification.Name.init("CurrentTodoEdited"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(currenttodoDeleted), name: NSNotification.Name.init("ToDoDeleted"), object: nil)
        TodosTv.dataSource = self
        TodosTv.delegate = self
    }
    
    @objc func AddTodoF (notification : Notification)
    {
       if  let mytodo = notification.userInfo?["AddTodoDic"] as? ArrayTodos
       {
        todos.append(mytodo)
        TodosTv.reloadData()
        TodoStorage.storeTodo(todo: mytodo)
        }
    }
    @objc func currenttodoEditet (notification:Notification){
        if let todo = notification.userInfo?["editettodo"] as? ArrayTodos {
            if let index = notification.userInfo?["editettodoindex"] as? Int {
                todos[index] = todo
                TodosTv.reloadData()
                TodoStorage.updateTodo(todo: todo, index: index)
            }
        }
        
        
    }
    @objc func currenttodoDeleted (notification:Notification){
        let confirm = UIAlertController(title: "confirm", message: "Do you agree to delete this todo", preferredStyle: UIAlertController.Style.alert)
        confirm.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.destructive, handler: { (_) in
               
                 if let index = notification.userInfo?["DeletedTodoIndex"] as? Int {
                    self.todos.remove(at: index)
                    self.TodosTv.reloadData()
                    TodoStorage.deleteTodo(index: index)
                     let alert = UIAlertController(title: "Done", message: "ToDo Deleted", preferredStyle: UIAlertController.Style.alert)
                     alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { (_) in
                         self.navigationController?.popViewController(animated: true)
                     }))
                     
                     self.present(alert, animated: true, completion:nil)
                     
        }
        }))
         
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler:nil)
        confirm.addAction(cancel)
        
          self.present(confirm, animated: true, completion: {})
        
          
    }
    
}

extension TodosVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOSVC") as! TodosCells
        cell.ContentTodos?.text = todos[indexPath.row].Content
        cell.imageTodos.image = todos[indexPath.row].image
        cell.imageTodos.layer.cornerRadius = cell.imageTodos.frame.size.width / 2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todo = todos[indexPath.row]
          let VC = (storyboard?.instantiateViewController(identifier: "StudingVC"))! as StudyVC
        VC.todo = todo
        VC.index = indexPath.row
        navigationController?.pushViewController(VC, animated: true)
            
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
