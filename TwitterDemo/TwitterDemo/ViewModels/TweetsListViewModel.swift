//
//  TweetsListViewModel.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import Foundation

protocol TweetsListViewModelDelegate: class {
    
    func didBeginTweetsFetching()
    func fetchTweetsFinishedWithError(message: String)
    func fetchTweetsFinished()
}

final class TweetsListViewModel {
    
    var tweetsList: TweetsList?
    weak var delegate: TweetsListViewModelDelegate?

    var isLoading: Bool = false
    let keys = GetPostKeys()
    
    func getTweetsInfo(tag: String) {
        // Validation - If any active request, cancelling current action.
        guard !isLoading else {
            return
        }
        isLoading = true
        delegate?.didBeginTweetsFetching()
        let params: Parameters = [keys.q: tag]
        DataManager.shared.fetchTweetsList(params) { (status, message, list) in
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
        return tweetsList?.statuses?.count ?? 0
    }
    
    func screenTitle() -> String? {
        return "Tweets"
    }
    
    func statusText(index: Int) -> String? {
        return tweetsList?.statuses?[index].text
    }
    
    func statusOwner(index: Int) -> String? {
        return tweetsList?.statuses?[index].user?.name
    }
    
    func getUserID(index: Int) -> String? {
        return tweetsList?.statuses?[index].user?.id_str
    }
    
    func statusOwnerImageUrl(index: Int) -> String? {
        return tweetsList?.statuses?[index].user?.profile_image_url_https
    }
}
