//
//  APIConnection.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

let kDefaultPagingStartIndex = 0


// Enpoint URL's
enum APIEndpoint: String {
   
    case baseUrl = "https://api.twitter.com"
    case fetchTweets = "/1.1/search/tweets.json"
    case fetchTimeline = "/1.1/statuses/user_timeline.json"
    
    var url: URL? {
        return URL(string: self.rawValue)
    }
    var string: String {
        return self.rawValue
    }
}

// Support Keys in GET and POST
struct GetPostKeys {
    
    let authorization = "Authorization"
    
    // Tweets List
    let q = "q"
    let language = "language"
    let userID = "user_id"
}
