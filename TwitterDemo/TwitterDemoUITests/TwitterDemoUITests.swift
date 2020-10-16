//
//  TwitterDemoUITests.swift
//  TwitterDemoUITests
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import XCTest

class TwitterDemoUITests: XCTestCase {

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

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testExistance() {
        let app = XCUIApplication()
        XCTAssertEqual(app.navigationBars.element.identifier, "Tweets")
    }
    
    func testSearching() {
        let app = XCUIApplication()
        app.tables.searchFields["Enter Hashtag.."].tap()
        app.searchFields["Enter Hashtag.."].typeText("modi")
        XCUIApplication().keyboards.buttons["search"].tap()
        let loaded = NSPredicate(format: "count > 0")
        expectation(for: loaded, evaluatedWith: app.tables.cells, handler: nil)

        waitForExpectations(timeout: 30, handler: nil) // Increase timeout depending on network speed
    }
}
