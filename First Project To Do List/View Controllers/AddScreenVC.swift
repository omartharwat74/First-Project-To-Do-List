//
//  AddScreenVC.swift
//  First Project To Do List
//
//  Created by Omar Tharwat on 3/13/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import UIKit

class AddScreenVC: UIViewController {
    
    var iscreate = true
    var edittodo : ArrayTodos?
    var editettodo : Int?
    @IBOutlet weak var AddImage: UIImageView!
    @IBOutlet weak var Containbutton: UIButton!
    @IBOutlet weak var AddTextField: UITextField!
    @IBOutlet weak var AddViewField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        if iscreate == false {
            Containbutton.setTitle("Edit", for: .normal )
          
        }
        
        if let todo = edittodo {
            AddTextField.text = todo.Content
            AddViewField.text = todo.details
            AddImage.image = todo.image
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChangePhotoButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func AddButton(_ sender: Any) {
        if iscreate == true {
            let todo = ArrayTodos(Content: AddTextField.text!, image: AddImage.image, details: AddViewField.text)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddTodo"), object: nil, userInfo: ["AddTodoDic" :todo])
        let alert = UIAlertController(title: "Done", message: "Todo Added", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { (_) in
                        self.tabBarController?.selectedIndex = 0
            self.AddTextField.text = ""
            self.AddViewField.text = ""

        }))
        self.present(alert, animated: true, completion:{} )
        }
        else {
            let todo = ArrayTodos(Content: AddTextField.text!, image: AddImage.image, details: AddViewField.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil, userInfo: ["editettodo":todo , "editettodoindex":editettodo!])
                       
                       let alert = UIAlertController(title: "Done", message: "Todo Edited", preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { (_) in
                               self.navigationController?.popViewController(animated: true)

                                  self.AddTextField.text = ""
                                  self.AddViewField.text = ""
                                self.AddImage.image = nil
    })
           
       )
             self.present(alert, animated: true, completion:{} )
        }  }
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddScreenVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
        AddImage.image = image
    }
    
    
    
}
