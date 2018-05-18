//
//  Peer.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 26/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 * This Class defines the Peers data model
 */
class Peer: Codable {
    
    //MARK: Properties
    
    /**
     Peer variables.
     */
    var peerName: String
    var peerUser: String
    var peerDevice: String
    
    //MARK: Initialisation
    
    /**
     Initialises a new Peer Object
     - Parameter peerName: The name of the peer (MCPeerID) String representatio
     - Parameter peerUser: The name a user types for the peer
     - Parameter peerDevice: The peer device
     */
    init(peerName: String, peerUser: String, peerDevice: String) {
        
        // Initialise stored properties
        self.peerName = peerName
        self.peerUser = peerUser
        self.peerDevice = peerDevice
        
    }
    
}
