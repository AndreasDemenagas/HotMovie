//
//  SearchController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.id)
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    fileprivate func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.75)])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    fileprivate func performSearch(searchTerm: String) {
        Service.shared.searchMovies(searchTerm: searchTerm) { (result) in
            switch result {
            case .failure(let error):
                print("Error in searching", error)
            case.success(let response):
                self.movies = response.results ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count > 0 ? movies.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm.count > 0 else {
            print("Invalid search term")
            return
        }
        
        performSearch(searchTerm: searchTerm)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = []
        tableView.reloadData()
    }
}


