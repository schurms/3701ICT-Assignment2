//
//  Utility.swift
//  Title: GettingThingsDone App - 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 29/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import Foundation

/**
 * This class provides Utility methods for the application
 */
class Utility {
    
    /**
     This Utility method is used to return a string version of a Date
     - Parameter theDate: A Date value
     - returns: A string representation of the Date in dd/MM/yyyy HH:mm format
     */
    static func dateToString(_ inDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        let returnDate = inDate
        return dateFormatter.string(from: returnDate as Date)
    }
    
    /**
     This property saves an item in JSON format
     - Parameter item: item data
     */
    static func saveItemToJSON(_ object: Item) {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = url.appendingPathComponent("gettingthingsdone.json")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: fileURL)
        } catch {
            fatalError("Error Writing JSON File")
        }
    }
    
    /**
     This property retrieves an item in JSON format
     - Parameter item: item data
     - Returns: The item from the file
     */
    static func getItemFromJSON() -> Item {
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = url.appendingPathComponent("gettingthingsdone.json")
        let decoder = JSONDecoder()
        do {
            let dataIn = try Data(contentsOf: fileURL)
            let dataOut = try decoder.decode(Item.self, from: dataIn)
            return dataOut
        } catch {
            fatalError("Error Reading JSON File")
        }
    }
}
