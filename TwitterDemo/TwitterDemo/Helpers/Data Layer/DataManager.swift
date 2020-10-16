//
//  DataManager.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    // Declarations
    static let shared = DataManager()
    let network = Network()
    let messages = Messages()
    let keys = GetPostKeys()
    
    // MARK: Life Cycle
    private override init() {
        super.init()
    }
}

extension DataManager {

    // Read all tweets with hashtag
    func fetchTweetsList(_ params: Parameters, completion: @escaping (_ status: Bool, _ statusMessage: String, _ checkinList: TweetsList?) -> ()) {

        // Send Request
        network.request(to: APIEndpoint.fetchTweets, method: HTTPMethod.get, encoding: HTTPEncoding.queryUrl, headers: HTTPHeaders(), queryParams: params, body: Data()) { (networkStatus, responseStatus, data) in

            /* Validations */

            // Network Error Case
            if !networkStatus {

                completion(false, self.messages.noConnection, nil)
                return
            }

            // Parse - Success Case
            if let resultsList: TweetsList = Parser.parse(data) {

                completion(true, self.messages.success, resultsList)
                return
            }

            // Server Error/ Parsing Error Cases
            completion(false, self.messages.serverNotResponding, nil)
        }
    }
}

extension DataManager {

    // Read all tweets with hashtag
    func fetchTweetsTimeline(_ params: Parameters, completion: @escaping (_ status: Bool, _ statusMessage: String, _ checkinList: [UserTimeline]?) -> ()) {

        // Send Request
        network.request(to: APIEndpoint.fetchTimeline, method: HTTPMethod.get, encoding: HTTPEncoding.queryUrl, headers: HTTPHeaders(), queryParams: params, body: Data()) { (networkStatus, responseStatus, data) in

            /* Validations */

            // Network Error Case
            if !networkStatus {

                completion(false, self.messages.noConnection, nil)
                return
            }

            // Parse - Success Case
            if let resultsList: [UserTimeline] = Parser.parse(data) {

                completion(true, self.messages.success, resultsList)
                return
            }

            // Server Error/ Parsing Error Cases
            completion(false, self.messages.serverNotResponding, nil)
        }
    }
}
