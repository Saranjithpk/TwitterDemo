//
//  TweetsList.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

struct TweetsList: Decodable {
    let statuses: [Status]?
}

struct Status: Decodable {
    let text: String?
    let user: RetweetedStatusUser?
}

struct RetweetedStatusUser: Decodable {
    let name: String?
    let profile_image_url_https: String
    let id_str: String?
}
