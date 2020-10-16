//
//  TweetListViewModelTest.swift
//  TwitterDemoTests
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import XCTest
@testable import TwitterDemo

class TweetsListViewModelTest: XCTestCase {
    let userName = "Test"
    let userProfileImageURL = "https://domain/image.png"
    let userID = "123456"
    
    let statusText1 = "Sample Text1"
    let statusText2 = "Sample Text2"
    
    var systemUnderTest: TweetsList!
    
    override func setUp() {
        super.setUp()
        let user = RetweetedStatusUser.init(name: userName, profile_image_url_https: userProfileImageURL, id_str: userID)
        let status1 = Status.init(text: "Sample Text1", user: user)
        let status2 = Status.init(text: "Sample Text2", user: user)

        systemUnderTest = TweetsList(statuses: [status1, status2])
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_InitializesUserName() {
        XCTAssertEqual(systemUnderTest.statuses?[0].user?.name, userName)
        XCTAssertEqual(systemUnderTest.statuses?[1].user?.name, userName)
    }
    
    func testSUT_InitializesUserProfileImage() {
        XCTAssertEqual(systemUnderTest.statuses?[0].user?.profile_image_url_https, userProfileImageURL)
        XCTAssertEqual(systemUnderTest.statuses?[1].user?.profile_image_url_https, userProfileImageURL)
    }
    
    func testSUT_InitializesUserID() {
        XCTAssertEqual(systemUnderTest.statuses?[0].user?.id_str, userID)
        XCTAssertEqual(systemUnderTest.statuses?[1].user?.id_str, userID)
    }
    
    func testSUT_InitializesStatuses() {
        XCTAssertEqual(systemUnderTest.statuses?[0].text, statusText1)
        XCTAssertEqual(systemUnderTest.statuses?[1].text, statusText2)
    }
    
}
