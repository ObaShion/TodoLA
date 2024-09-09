//
//  Todo.swift
//  TodoLA
//
//  Created by 大場史温 on 2024/09/02.
//

import Foundation

class Todo: Codable {
    var title: String = ""
    var detail: String = ""
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}
