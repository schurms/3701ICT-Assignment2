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
    var itemCollaborator: [Collaborator]
    var itemPeer: [Peer]
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" item
     - Parameter UUID: Unique item identifier regardless if they have the same title
     - Parameter title: The title of the item
     - Parameter complete: Indicates if item is complete
     - Parameter itemHistory: Array of history for an item
     - Parameter itemCollaborator: Array of Collaborators for an item
     - Parameter itemPeer: Array of Peers for an item
     - Returns: A "To Do" item.
     */
    init(itemIdentifier: UUID, title: String, done: Bool, itemHistory: [History], itemCollaborator: [Collaborator], itemPeer: [Peer]) {
        
        // Initialise stored properties
        self.itemIdentifier = itemIdentifier
        self.title = title
        self.done = done
        self.itemHistory = itemHistory
        self.itemCollaborator = itemCollaborator
        self.itemPeer = itemPeer
        
    }
    
    /**
     This property saves an item in JSON format
     - Parameter item: item data
     */
    func saveItemToJSON(_ object: Item) {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = url.appendingPathComponent("gettingthingsdone.json")
        print(fileURL)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: fileURL)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
