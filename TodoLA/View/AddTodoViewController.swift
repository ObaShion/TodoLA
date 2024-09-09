//
//  AddTodoViewController.swift
//  TodoLA
//
//  Created by 大場史温 on 2024/09/02.
//

import UIKit

class AddTodoViewController: UIViewController {

    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var detailTextField: UITextField!
    
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarController?.hidesBottomBarWhenPushed
    }
    
    @IBAction func save() {
        saveToDb()
    }
    
    func saveToDb() {
        todos = DBCore().loadTodos() ?? []
        
        if titleTextField.text == "" || detailTextField.text == "" {
            let alert = UIAlertController(title: "未入力", message: "Todoを入力してください", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alert, animated: true)
            return
        }
        
        todos.insert(Todo(title: titleTextField.text ?? "", detail: detailTextField.text ?? ""), at: 0)
        
        DBCore().saveTodos(todos: todos)
        
        self.navigationController?.popViewController(animated: true)
    }
}
