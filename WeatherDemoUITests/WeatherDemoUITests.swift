//
//  WeatherDemoUITests.swift
//  WeatherDemoUITests
//
//  Created by Anis Ur Rehman on 05/07/2023.
//

import XCTest

final class WeatherDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        sleep(1) // Let api get called
        let multanCell = app.tables.cells.containing(NSPredicate(format: "label CONTAINS %@", "Multan")).firstMatch
        XCTAssertTrue(multanCell.exists)
        multanCell.tap()
        
        var navigationBar = app.navigationBars.containing(NSPredicate(format: "label CONTAINS %@", "Multan")).firstMatch
        XCTAssertTrue(navigationBar.exists)
        
        app.navigationBars.buttons.firstMatch.tap()
        
        let karachiCell = app.tables.cells.containing(NSPredicate(format: "label CONTAINS %@", "Karachi")).firstMatch
        XCTAssertTrue(karachiCell.exists)
        karachiCell.tap()
        
        navigationBar = app.navigationBars.containing(NSPredicate(format: "label CONTAINS %@", "Karachi")).firstMatch
        XCTAssertTrue(navigationBar.exists)
    }
}
