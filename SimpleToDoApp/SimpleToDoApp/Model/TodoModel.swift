//
//  TodoModel.swift
//  SimpleToDoApp
//
//  Created by Pratik Mandi on 15/12/25.
//

import Foundation
import SwiftData

@Model
class TodoModel{
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
