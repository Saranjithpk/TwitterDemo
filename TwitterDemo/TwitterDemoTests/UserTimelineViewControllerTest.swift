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

class UserTimelineViewControllerTest: XCTestCase {
    
    var viewControllerUnderTest: TimelineTweetsViewController!
    
    override func setUp() {
        super.setUp()
        
        self.viewControllerUnderTest = TimelineTweetsViewController()

        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
        self.viewControllerUnderTest.tweetsViewModel.tweetsList = samplePosts()
    }
    
    func samplePosts() -> [UserTimeline] {
        let user = RetweetedStatusUser.init(name: "user", profile_image_url_https: "", id_str: "")

        let timelinePost1 = UserTimeline(text: "Post1", user: user)
        let timelinePost2 = UserTimeline(text: "Post2", user: user)
        let timelinePost3 = UserTimeline(text: "Post3", user: user)
        return [timelinePost1, timelinePost2, timelinePost3]
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
        XCTAssertEqual(cell0.detailTextLabel?.text, "Post1")
        
        let cell1 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(cell1.detailTextLabel?.text, "Post2")
        
        let cell2 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        XCTAssertEqual(cell2.detailTextLabel?.text, "Post3")
        
        XCTAssertEqual(cell0.textLabel?.text, "user")
        XCTAssertEqual(cell1.textLabel?.text, "user")
        XCTAssertEqual(cell2.textLabel?.text, "user")
    }
}
