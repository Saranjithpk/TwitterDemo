//
//  UserTweets.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

struct UserTimeline: Decodable {
    let text: String?
    let user: RetweetedStatusUser?
}
