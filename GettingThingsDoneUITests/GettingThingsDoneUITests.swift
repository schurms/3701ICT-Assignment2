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
    
    // Set the app variables
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        app.launch()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     * Test that one tap the Todo Item is incremented
     */
    func testMasterViewTodoItemAddedOneTap() {

        let addButton = app.navigationBars["Things To Do"].buttons["Add"]
        addButton.tap()
        
        let tableCellContainer = app.tables.cells.element(boundBy: 0)
        let cell = tableCellContainer.staticTexts["Todo Item 1"]
       
        XCTAssertTrue(cell.exists)
    }
    
    /**
     * Test that two taps the Todo Item is incremented
     */
    func testMasterViewTodoItemAddedTwoTap() {
        
        let addButton = app.navigationBars["Things To Do"].buttons["Add"]
        addButton.tap()
        addButton.tap()
    
        let tableCellContainer = app.tables.cells.element(boundBy: 1)
        let cell = tableCellContainer.staticTexts["Todo Item 2"]
        
        XCTAssertTrue(cell.exists)
    }
    
    /**
     * Test that Table Exists
     */
    func testMasterViewTodoItemTableExists() {
        
        let addButton = app.navigationBars["Things To Do"].buttons["Add"]
        addButton.tap()
        
        let table = app.tables.element
        
        XCTAssert(table.exists)
    }
    
    /**
     * Test that edited cells in detail are correctly returned to master
     */
    func testMasterToDetail() {
        
        app.navigationBars["Things To Do"].buttons["Add"].tap()
        
        let app2 = app
        sleep(3)
        app2.tables/*@START_MENU_TOKEN@*/.staticTexts["Todo Item 1"]/*[[".cells.staticTexts[\"Todo Item 1\"]",".staticTexts[\"Todo Item 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.tap()
        
        let yKey = app2/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        yKey.tap()
        sleep(1)
        app2/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Master"].buttons["Things To Do"].tap()
        let tableCellContainer = app.tables.cells.element(boundBy: 0)
        let cell = tableCellContainer.staticTexts["Todo Item 1yy"]
        
        XCTAssertTrue(cell.exists)
    }
    
    /**
     * Test that Table cells are correctly deleted
     */
    func testMasterCellDelete() {

        let thingsToDoNavigationBar = app.navigationBars["Things To Do"]
        thingsToDoNavigationBar.buttons["Add"].tap()
        sleep(1)
        thingsToDoNavigationBar.buttons["Edit"].tap()
        sleep(1)
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete Todo Item 1"]/*[[".cells.buttons[\"Delete Todo Item 1\"]",".buttons[\"Delete Todo Item 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.buttons["Delete"].tap()
        thingsToDoNavigationBar.buttons["Done"].tap()
        
        XCTAssert(app.tables.cells.count == 0)
    }
}
