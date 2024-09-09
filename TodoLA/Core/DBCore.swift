//
//  DBCore.swift
//  TodoLA
//
//  Created by 大場史温 on 2024/09/02.
//

import Foundation

class DBCore {
    
    let db = UserDefaults.standard
    
    func saveTodos(todos: [Todo]) {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(todos) {
               db.set(encoded, forKey: "todos")
           }
       }
    
    func loadTodos() -> [Todo]? {
            if let savedTodos = db.object(forKey: "todos") as? Data {
                let decoder = JSONDecoder()
                if let loadedTodos = try? decoder.decode([Todo].self, from: savedTodos) {
                    return loadedTodos
                }
            }
            return nil
        }
}
