//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by 孟元森 on 2024-05-21.
//

import Foundation

@Observable
class TodoListViewModel {
    
    // MARK: Stored properties
    // The list of to-do items
    var todos: [TodoItem]
    
    // MARK: Initializer(s)
    init(todos: [TodoItem] = []) {
        self.todos = todos
        Task {
                   try await getTodos()
               }
    }
    func getTodos() async throws {
           
           do {
               let results: [TodoItem] = try await supabase
                   .from("todos")
                   .select()
                   .execute()
                   .value
               
               self.todos = results
               
           } catch {
               debugPrint(error)
           }
           
       }
    // MARK: Functions
    func createToDo(withTitle title: String) {
        
        // Create the new to-do item instance
        let todo = TodoItem(
            title: title,
            done: false
        )
        
        // Append to the array
        todos.append(todo)
        
    }
    
    func delete(_ todo: TodoItem) {
        
        // Remove the provided to-do item from the array
        todos.removeAll { currentItem in
            currentItem.id == todo.id
        }
        
    }
    
}
