//
//  History.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 26/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 * This Class defines the History used to store a "To Do" History
 */
class History: Codable {
    
    //MARK: Properties
    
    /**
     To Do History variables.
     */
    var historyDate: Date
    var historyDescription: String
    var historyEditable: Bool
    
    //MARK: Initialisation
    
    /**
     Initialises a new "To Do" History item
     - Parameter historyDate: The date the history event occurred
     - Parameter historyDescription: A description of the history event
     - Parameter historyEditable: Indicates whether the history record is editable
     - Returns: A "History" for an item.
     */
    init(historyDate: Date, historyDescription: String, historyEditable: Bool) {
        
        // Initialise stored properties
        self.historyDate = historyDate
        self.historyDescription = historyDescription
        self.historyEditable = historyEditable
        
    }
    
}
