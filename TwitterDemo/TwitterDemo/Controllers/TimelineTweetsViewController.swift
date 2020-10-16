//
//  TimelineTweetsViewController.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 16/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import UIKit

class TimelineTweetsViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var tweetsViewModel = UserTimelineViewModel()

    var userID: String?
    
    override func loadView() {
        super.loadView()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsViewModel.delegate = self
        
        if let userID = userID {
            tweetsViewModel.getTimelineTweets(userId: userID)
        }
    }
}

private extension TimelineTweetsViewController {
    
    func setupNavigationBar() {
        title = tweetsViewModel.screenTitle()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tweetDisplayCell")
    }
    
}

extension TimelineTweetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "tweetDisplayCell")
        cell.textLabel?.text = tweetsViewModel.statusOwner(index: indexPath.row)
        cell.detailTextLabel?.text = tweetsViewModel.statusText(index: indexPath.row)
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}

extension TimelineTweetsViewController: UserTimelineViewModelDelegate {
    
    func didBeginTweetsFetching() {
        DispatchQueue.main.async {
            self.showSpinner(view: self.view)
        }
    }
    
    func fetchTweetsFinishedWithError(message: String) {
        DispatchQueue.main.async {
            self.removeSpinner()
            // Handle error
        }
    }
    
    func fetchTweetsFinished() {
        DispatchQueue.main.async {
            self.removeSpinner()
            self.tableView.reloadData()
            self.setupNavigationBar()
        }
    }
}
