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
    func testHistoryClass1() {
        
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
     Tests Class Peer - Valid Items
     */
    func testCollaboratorClass1() {
        
        // Test Data model all Valid data
        let collaboratorName: String = "John"

        let itemCollaborator = Collaborator(collaboratorName: collaboratorName)
        XCTAssertEqual(itemCollaborator.collaboratorName, collaboratorName)
    }
    
    /**
     Tests Class Peer - Valid Items
     */
    func testPeerClass1() {
        
        // Test Data model all Valid data
        let peerName: String = "John"
        let peerDevice: String = "iPhone"
        
        let itemPeer = Peer(peerName: peerName, peerDevice: peerDevice)
        XCTAssertEqual(itemPeer.peerName, peerName)
        XCTAssertEqual(itemPeer.peerDevice, peerDevice)
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
    
}
