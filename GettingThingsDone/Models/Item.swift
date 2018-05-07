//
//  Item.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 26/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 * This Class defines an Item used to store a "To Do"
 */
class Item: Codable {
    
    //MARK: Properties
    
    /**
     To Do item variables.
     */
    var itemIdentifier: UUID
    var title: String
    var done: Bool
    var itemHistory: [History]
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" item
     - Parameter UUID: Unique item identifier regardless if they have the same title
     - Parameter title: The title of the item
     - Parameter done: Indicates if item is complete
     - Parameter itemHistory: Array of history for an item
     - Returns: A "To Do" item.
     */
    init(itemIdentifier: UUID, title: String, done: Bool, itemHistory: [History]) {
        
        // Initialise stored properties
        self.itemIdentifier = itemIdentifier
        self.title = title
        self.done = done
        self.itemHistory = itemHistory
        
    }

}
