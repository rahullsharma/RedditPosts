//
//  ViewController.swift
//  RedditListings
//
//  Created by Rahul Sharma on 1/1/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import SnapKit
import UIKit
import WebKit

class ViewController: UIViewController {

    let vm = ListingsModel()
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        createSearchBar()
        vm.getListings(subreddit: "") { data, err in
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource,  WKNavigationDelegate, WKUIDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.children.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = vm.children[indexPath.row].data.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .blue
        
        cell.detailTextLabel?.text = "Upvotes: \(vm.children[indexPath.row].data.ups) | Downvotes: \(vm.children[indexPath.row].data.downs) | \(vm.children[indexPath.row].data.subreddit)"
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(WebViewController(urlString: vm.children[indexPath.row].data.url), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints() { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            guard let text = searchController.searchBar.text else {return}
            vm.getListings(subreddit: text) { _ , _ in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a Subreddit"
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
