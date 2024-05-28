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
        
        // Create a unit of asynchronous work to add the to-do item
        Task {
            
            // Create the new to-do item instance
            // NOTE: The id will be nil for now
            let todo = TodoItem(
                title: title,
                done: false
            )
            
            // Write it to the database
            do {
                
                // Insert the new to-do item, and then immediately select
                // it back out of the database
                let newlyInsertedItem: TodoItem = try await supabase
                    .from("todos")
                    .insert(todo)   // Insert the todo item created locally in memory
                    .select()       // Select the item just inserted
                    .single()       // Ensure just one row is returned
                    .execute()      // Run the query
                    .value          // Automatically decode the JSON into an instance of TodoItem

                // Finally, insert the to-do item instance we just selected back from the
                // database into the array used by the view model
                // NOTE: We do this to obtain the id that is automatically assigned by Supabase
                //       when the to-do item was inserted into the database table
                self.todos.append(newlyInsertedItem)
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func delete(_ todo: TodoItem) {
            
            // Create a unit of asynchronous work to add the to-do item
            Task {
                
                do {
                    
                    // Run the delete command
                    try await supabase
                        .from("todos")
                        .delete()
                        .eq("id", value: todo.id!)  // Only delete the row whose id
                        .execute()                  // matches that of the to-do being deleted
                    
                    // Update the list of to-do items held in memory to reflect the deletion
                    try await self.getTodos()

                } catch {
                    debugPrint(error)
                }
                
                
            }
                    
        }
    func update(todo updatedTodo: TodoItem) {
            
            // Create a unit of asynchronous work to add the to-do item
            Task {
                
                do {
                    
                    // Run the update command
                    try await supabase
                        .from("todos")
                        .update(updatedTodo)
                        .eq("id", value: updatedTodo.id!)   // Only update the row whose id
                        .execute()                          // matches that of the to-do being deleted
                        
                } catch {
                    debugPrint(error)
                }
                
            }
            
        }
