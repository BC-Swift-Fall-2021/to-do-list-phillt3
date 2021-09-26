//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Phillip  Tracy on 9/24/21.
//

import Foundation

struct ToDoItem : Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
}
