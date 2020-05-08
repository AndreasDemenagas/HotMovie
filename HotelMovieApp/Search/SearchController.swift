//
//  SearchController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let searchCellId = "searchCellId"
    
    fileprivate let enterSearchLabel = UILabel(text: "Please enter search term above...", font: .boldSystemFont(ofSize: 20), alignment: .center)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(enterSearchLabel)
        enterSearchLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 32, left: 16, bottom: 0, right: 0), size: .init(width: view.frame.width - 32, height: 50))
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.alwaysBounceVertical = false
        tableView.register(SearchCell.self, forCellReuseIdentifier: searchCellId)
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
        enterSearchLabel.isHidden = movies.count > 0 ? true : false
        return movies.count > 0 ? movies.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: searchCellId, for: indexPath) as! SearchCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController = MovieDetailsController(collectionViewLayout: UICollectionViewFlowLayout())
        detailsController.movie = movies[indexPath.row]
        present(detailsController, animated: true)
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


