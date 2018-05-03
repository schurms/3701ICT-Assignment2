//
//  GettingThingsDoneUITests.swift
//  GettingThingsDone
//  Title: 3701ICT Assignment 2
//  Student: s5073958
//  Created by Jordan Schurmann on 21/4/18.
//  Copyright © 2018 Jordan Schurmann. All rights reserved.
//

import XCTest

class GettingThingsDoneUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        print(app.debugDescription)

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTodoItemAddedOneTap() {
        
        let app = XCUIApplication()
        let addButton = app.navigationBars["Things To Do"].buttons["Add"]
        addButton.tap()
        
        let table = app.tables.element
        XCTAssert(table.exists)
        
        let tableCellContainer = app.tables.cells.element(boundBy: 0)
        let cell = tableCellContainer.staticTexts["Todo Item 1"]
       
        XCTAssertTrue(cell.exists)
    }
    
    /**
     * Test that two taps the Todo Item is incremented
     */
    func testTodoItemAddedTwoTap() {
        
        let addButton = app.navigationBars["Things To Do"].buttons["Add"]
        addButton.tap()
        addButton.tap()
    
        let tableCellContainer = app.tables.cells.element(boundBy: 1)
        let cell = tableCellContainer.staticTexts["Todo Item 2"]
        
        XCTAssertTrue(cell.exists)
    }
    
    
}
