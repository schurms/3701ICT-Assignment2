//
//  GettingThingsDoneTests.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import XCTest
@testable import GettingThingsDone

class GettingThingsDoneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     Tests Class History - Valid Items
     */
    func testHistoryClass() {
        
        // Test Data model all Valid data
        let historyDate: Date = Date()
        let historyDescription: String = "New History Record"
        let historyEditable: Bool = true
        
        let itemHistory = History(historyDate: historyDate, historyDescription: historyDescription, historyEditable: historyEditable)
        XCTAssertEqual(itemHistory.historyDate, historyDate)
        XCTAssertEqual(itemHistory.historyDescription, historyDescription)
        XCTAssertEqual(itemHistory.historyEditable, historyEditable)
    }
    
    /**
     Tests Class Collaborator - Valid Items
     */
    func testCollaboratorClass() {
        
        // Test Data model all Valid data
        let collaboratorID: String = "ABC"
        let collaboratorName: String = "John"
        let collaboratorDevice: String = "iPhone"

        let itemCollaborator = Collaborator(collaboratorID: collaboratorID, collaboratorName: collaboratorName, collaboratorDevice: collaboratorDevice)
        XCTAssertEqual(itemCollaborator.collaboratorID, collaboratorID)
        XCTAssertEqual(itemCollaborator.collaboratorName, collaboratorName)
        XCTAssertEqual(itemCollaborator.collaboratorDevice, collaboratorDevice)
    }
    
    /**
     Tests Class Peer - Valid Items
     */
    func testPeerClass() {
        
        // Test Data model all Valid data=
        let peerName: String = "ABC"
        let peerUser: String = "Bill"
        let peerDevice: String = "iPhone"
        
        let itemPeer = Peer(peerName: peerName, peerUser: peerUser, peerDevice: peerDevice)
        XCTAssertEqual(itemPeer.peerName, peerName)
        XCTAssertEqual(itemPeer.peerDevice, peerDevice)
    }
    
    /**
     Tests Class Item - Valid Items
     */
    func testItemClass() {
        
        // Set up History Record
        let historyDate: Date = Date()
        let historyDescription: String = "New History Record"
        let historyEditable: Bool = true
        let itemHistory = History(historyDate: historyDate, historyDescription: historyDescription, historyEditable: historyEditable)
        
        //Set up Collaborator Record
        let collaboratorID: String = "ABC"
        let collaboratorName: String = "John"
        let collaboratorDevice: String = "iPhone"
        
        let itemCollaborator = Collaborator(collaboratorID: collaboratorID, collaboratorName: collaboratorName, collaboratorDevice: collaboratorDevice)
        
        // Set up Item Record
        let itemIdentifier: UUID = UUID()
        let title: String = "Todo Item 1"
        let done: Bool = false
        let item = Item(itemIdentifier: itemIdentifier, title: title, done: done, itemHistory: [itemHistory], itemCollaborator: [itemCollaborator])
        
        XCTAssertEqual(item.itemIdentifier, itemIdentifier)
        XCTAssertEqual(item.title, title)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.itemHistory[0].historyDate, historyDate)
        XCTAssertEqual(item.itemHistory[0].historyDescription, historyDescription)
        XCTAssertEqual(item.itemHistory[0].historyEditable, historyEditable)
        XCTAssertEqual(item.itemCollaborator[0].collaboratorID, collaboratorID)
        XCTAssertEqual(item.itemCollaborator[0].collaboratorName, collaboratorName)
        XCTAssertEqual(item.itemCollaborator[0].collaboratorDevice, collaboratorDevice)
    }
    
    /**
     Test Date converted to String are equal
     Note given dates change must use date to string for comparison
     */
    func testDateToStringEqual() {
        
        // Test utility method date conversion
        let outCompareDate = Utility.dateToString(Date())
        let inCompareDate = Date()
        XCTAssertEqual(Utility.dateToString(inCompareDate),outCompareDate)
    }
    
    /**
     Test Date converted to String are not equal
     Note given dates change must use date to string for comparison
     */
    func testDateToStringNotEqual() {
        
        // Test utility method date conversion
        let outCompareDate = Utility.dateToString(Date())
        let inTodayDate = Date()
        let inCompareDate = Calendar.current.date(byAdding: .day, value: 1, to: inTodayDate)
        XCTAssertNotEqual(Utility.dateToString(inCompareDate!),outCompareDate)
    }
    
    /**
     Test ToDoListViewController instance successfully created
     */
    func testMasterViewController() {
        
        // Test MasterViewController instance created
        let todoVC = MasterViewController()
        let todoView = todoVC.view
        XCTAssertNotNil(todoView, "Cannot find MasterViewController view instance");
    }
    
    /**
     Test DetailViewController instance successfully created
     */
    func testDetailViewController() {
        
        // Test DetailViewController instance created
        let todoVC = DetailViewController()
        let todoView = todoVC.view
        XCTAssertNotNil(todoView, "Cannot find DetailViewController view instance");
    }
    
    /**
     Test Item correctly Saved and retrieved from JSON
     */
    func testItemSaveToJSON() {
        
        // Set up History Record
        let historyDate: Date = Date()
        let historyDescription: String = "New History Record"
        let historyEditable: Bool = true
        let itemHistory = History(historyDate: historyDate, historyDescription: historyDescription, historyEditable: historyEditable)
        
        //Set up Collaborator Record
        let collaboratorID: String = "ABC"
        let collaboratorName: String = "New Collaborator"
        let collaboratorDevice: String = "iPhone"
        let itemCollaborator = Collaborator(collaboratorID: collaboratorID, collaboratorName: collaboratorName, collaboratorDevice: collaboratorDevice)
        
        // Set up Item Record
        let itemIdentifier: UUID = UUID()
        let title: String = "Todo Item 1"
        let done: Bool = false
        let item = Item(itemIdentifier: itemIdentifier, title: title, done: done, itemHistory: [itemHistory], itemCollaborator: [itemCollaborator])
        
        // Save item to JSON
        Utility.saveItemToJSON(item)
        
        // Get item from JSON
        let itemData = Utility.getDataFromJSON()
        
        do {
            let receivedItem = try JSONDecoder().decode(Item.self, from: itemData)
            // Test Returned saved item = item saved
            XCTAssertEqual(receivedItem.title, item.title)
        } catch {
            print("Unable to process received data")
        }
    }
}
