//
//  StudyVC.swift
//  First Project To Do List
//
//  Created by Omar Tharwat on 3/7/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
     
    var todo : ArrayTodos!
    var index : Int!
    @IBOutlet weak var ImageLabel: UIImageView!
    @IBOutlet weak var DetailsLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        ImageLabel.image = todo.image
       setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(currenttodoEditet), name: NSNotification.Name.init("CurrentTodoEdited"), object: nil)
    }
    @objc func currenttodoEditet (notification:Notification){
          if let todo = notification.userInfo?["editettodo"] as? ArrayTodos {
            self.todo = todo
           setupUI()
          }
          
          
      }
    func setupUI() {
        DetailsLabel.text = todo.details
               ContentLabel.text = todo.Content
        ImageLabel.image = todo.image
    }
    
    @IBAction func EditLabel(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddScreenVC") as? AddScreenVC
        vc?.iscreate = false
        vc?.edittodo = todo
        vc?.editettodo = index
        navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ToDoDeleted"), object: nil, userInfo: ["DeletedTodoIndex":index! ])
    }
    
}
