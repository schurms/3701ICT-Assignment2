//
//  Collaborator.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 26/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 * This Class defines the Collabortors data model
 */
class Collaborator {
    
    //MARK: Properties
    
    /**
     Collaborator variables.
     */
    var collaboratorName: String
    
    //MARK: Initialisation
    
    /**
     Initialises a new Collaborator Object
     - Parameter collaboratorName: The name of the collaborator
     - Returns: A collaborator Name.
     */
    init(collaboratorName: String) {
        
        // Initialise stored properties
        self.collaboratorName = collaboratorName
        
    }
    
}
