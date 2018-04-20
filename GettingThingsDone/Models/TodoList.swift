//
//  TodoList.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 This Class defines a Todo Section
 */
class TodoList  {
    
    //MARK: Properties
    
    /**
     TodoList variables
     */
    var todoSection: String        // name of section
    var todos: [Todo]              // all todos in the section
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" section
     - Parameter todoSection: The title of the todo section
     - Parameter todos: An array of todo items
     - Returns: A "To Do" aray.
     */
    init(todoSection: String, todos: [Todo]) {
        
        // Initialise stored properties
        self.todoSection = todoSection
        self.todos = todos
    }
    
    class func todoLists() -> [TodoList] {
        return [self.YetToDo(), self.Completed()]
    }
    
    // Private Methods
    
    private class func YetToDo() -> TodoList {
        // Yet to do items
        var todos = [Todo]()
        todos.append(Todo(title: "Todo Item 1"))
        
        return TodoList(todoSection: "YET TO DO", todos: todos)
    }
    
    private class func Completed() -> TodoList {
        // Yet to do items
        var todos = [Todo]()
        todos.append(Todo(title: "Todo Item 2"))
        
        return TodoList(todoSection: "COMPLETED", todos: todos)
    }
}
