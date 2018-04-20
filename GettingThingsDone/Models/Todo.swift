//
//  Todo.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 This Class defines a Todo item
 */
class Todo  {
    
    //MARK: Properties
    
    /**
     Todo variables
     */
    var title: String
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" item
     - Parameter title: The title of the todo
     - Returns: A "To Do" item.
     */
    init(title: String) {
        
        // Initialise stored properties
        self.title = title
    }
}
