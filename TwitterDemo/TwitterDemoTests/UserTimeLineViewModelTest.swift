//
//  UserTimeLineViewModelTest.swift
//  TwitterDemoTests
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import XCTest
@testable import TwitterDemo

class UserTimeLineViewModelTest: XCTestCase {
    
    let userName = "Test"
    let userProfileImageURL = "https://domain/image.png"
    let userID = "123456"
    
    let statusText1 = "Sample Text1"
    let statusText2 = "Sample Text2"
    
    var systemUnderTest: [UserTimeline]!
    
    override func setUp() {
        super.setUp()
        let user = RetweetedStatusUser.init(name: userName, profile_image_url_https: userProfileImageURL, id_str: userID)
        
        let timelinePost1 = UserTimeline(text: statusText1, user: user)
        let timelinePost2 = UserTimeline(text: statusText2, user: user)
        
        systemUnderTest = [timelinePost1, timelinePost2]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_InitializesPosts() {
        XCTAssertEqual(systemUnderTest[0].text, statusText1)
        XCTAssertEqual(systemUnderTest[1].text, statusText2)
    }
    
    func testSUT_InitializesUserName() {
        XCTAssertEqual(systemUnderTest[0].user?.name, userName)
        XCTAssertEqual(systemUnderTest[1].user?.name, userName)
    }
    
    func testSUT_InitializesUserProfileImage() {
        XCTAssertEqual(systemUnderTest[0].user?.profile_image_url_https, userProfileImageURL)
        XCTAssertEqual(systemUnderTest[1].user?.profile_image_url_https, userProfileImageURL)
    }
    
    func testSUT_InitializesUserID() {
        XCTAssertEqual(systemUnderTest[0].user?.id_str, userID)
        XCTAssertEqual(systemUnderTest[1].user?.id_str, userID)
    }

}
