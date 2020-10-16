//
//  TweetsViewControllerSwift.swift
//  TwitterDemoTests
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

import XCTest
@testable import TwitterDemo

class TweetsViewControllerTest: XCTestCase {
    
    var viewControllerUnderTest: TweetsViewController!
    
    override func setUp() {
        super.setUp()
        
        self.viewControllerUnderTest = TweetsViewController()

        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
        self.viewControllerUnderTest.tweetsViewModel.tweetsList = sampleTweets()
    }
    
    func sampleTweets() -> TweetsList {
        let user = RetweetedStatusUser.init(name: "user", profile_image_url_https: "", id_str: "")
        let status1 = Status.init(text: "Text1", user: user)
        let status2 = Status.init(text: "Text2", user: user)
        let status3 = Status.init(text: "Text3", user: user)

        let tweetList = TweetsList(statuses: [status1, status2, status3])
        return tweetList
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "tweetDisplayCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell0.detailTextLabel?.text, "Text1")
        
        let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell1.detailTextLabel?.text, "Text2")
        
        let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        XCTAssertEqual(cell2.detailTextLabel?.text, "Text3")
        
        XCTAssertEqual(cell0.textLabel?.text, "user")
        XCTAssertEqual(cell1.textLabel?.text, "user")
        XCTAssertEqual(cell2.textLabel?.text, "user")
    }
}
