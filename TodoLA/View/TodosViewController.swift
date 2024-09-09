//
//  TodosViewController.swift
//  TodoLA
//
//  Created by 大場史温 on 2024/09/02.
//

import UIKit

class TodosViewController: UIViewController{

    @IBOutlet var table: UITableView!
    
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        todos = DBCore().loadTodos() ?? []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todos = DBCore().loadTodos() ?? []
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditView" {
            guard let destination = segue.destination as? EdtiTodoViewController else {
                fatalError("Failed to prepare EdtiTodoViewController.")
            }
            destination.todo = todos[table.indexPathForSelectedRow!.row]
            destination.index = table.indexPathForSelectedRow!.row
        }
    }

}

extension TodosViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title
        cell.detailTextLabel?.text = todos[indexPath.row].detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        todos.remove(at: indexPath.row)
        
        DBCore().saveTodos(todos: todos)

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
