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
class Item {
    
    //MARK: Properties
    
    /**
     To Do item variables.
     */
    var title: String
    var done: Bool
    var itemHistory: [History]
    var itemCollaborator: [Collaborator]
    var itemPeer: [Peer]
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" item
     - Parameter title: The title of the item
     - Parameter complete: Indicates if item is complete
     - Parameter itemHistory: Array of history for an item
     - Parameter itemCollaborator: Array of Collaborators for an item
     - Parameter itemPeer: Array of Peers for an item
     - Returns: A "To Do" item.
     */
    init(title: String, done: Bool, itemHistory: [History], itemCollaborator: [Collaborator], itemPeer: [Peer]) {
        
        // Initialise stored properties
        self.title = title
        self.done = done
        self.itemHistory = itemHistory
        self.itemCollaborator = itemCollaborator
        self.itemPeer = itemPeer
        
    }
    
}
