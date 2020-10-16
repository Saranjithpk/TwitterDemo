//
//  ViewController.swift
//  TwitterDemo
//
//  Created by Saranjith Pk on 15/10/20.
//  Copyright © 2020 Saranjith Pk. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var tweetsViewModel = TweetsListViewModel()
    
    fileprivate lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Enter Hashtag.."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()

    override func loadView() {
        super.loadView()
        setupTableView()
        setupSearchBar()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsViewModel.delegate = self
    }
}

private extension TweetsViewController {
    
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
    
    func setupSearchBar() {
        tableView.tableHeaderView = searchBar
        searchBar.delegate = self
    }
    
}

extension TweetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let timelineController = TimelineTweetsViewController()
        timelineController.userID = tweetsViewModel.getUserID(index: indexPath.row)
        self.navigationController?.pushViewController(timelineController, animated: true)
    }
}

extension TweetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "tweetDisplayCell")
        cell.textLabel?.text = tweetsViewModel.statusOwner(index: indexPath.row)
        cell.detailTextLabel?.text = tweetsViewModel.statusText(index: indexPath.row)
        cell.detailTextLabel?.numberOfLines = 0
        if let profileImageLink = tweetsViewModel.statusOwnerImageUrl(index: indexPath.row) {
            cell.imageView?.downloadFromLink(link: profileImageLink, contentMode: .center, completionHandler: {
                cell.setNeedsLayout()
            })
        }
        return cell
    }
}

extension TweetsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let enteredText = searchBar.text else {
            return
        }
        tweetsViewModel.getTweetsInfo(tag: enteredText, page: 0)
    }
}

extension TweetsViewController: TweetsListViewModelDelegate {
    
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
        }
    }
}
