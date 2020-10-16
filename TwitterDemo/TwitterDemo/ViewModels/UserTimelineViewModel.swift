//
//  UserTimelineViewModel.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

protocol UserTimelineViewModelDelegate: class {
    
    func didBeginTweetsFetching()
    func fetchTweetsFinishedWithError(message: String)
    func fetchTweetsFinished()
}

final class UserTimelineViewModel {
    
    var tweetsList: [UserTimeline]?
    weak var delegate: UserTimelineViewModelDelegate?

    var isLoading: Bool = false
    let keys = GetPostKeys()
    
    func getTimelineTweets(userId: String) {
        // Validation - If any active request, cancelling current action.
        guard !isLoading else {
            return
        }
        isLoading = true
        delegate?.didBeginTweetsFetching()
        let params: Parameters = [keys.userID: userId]
        DataManager.shared.fetchTweetsTimeline(params) { (status, message, list) in
            self.isLoading = false
            if status {
                self.tweetsList = list
                self.delegate?.fetchTweetsFinished()
            } else {
                self.delegate?.fetchTweetsFinishedWithError(message: message)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return tweetsList?.count ?? 0
    }
    
    func screenTitle() -> String? {
        return tweetsList?[0].user?.name
    }
    
    func statusText(index: Int) -> String? {
        return tweetsList?[index].text
    }
    
    func statusOwner(index: Int) -> String? {
        return tweetsList?[0].user?.name
    }
}
