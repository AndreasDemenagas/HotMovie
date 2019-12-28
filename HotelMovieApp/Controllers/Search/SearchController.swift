//
//  SearchController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 21/11/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellid = "cellid"
    
    var movies = [Movie]()
    
    fileprivate let enterSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(MovieSearchCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.addSubview(enterSearchLabel)
        enterSearchLabel.anchor(top: collectionView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: 32, bottom: 0, right: 32), size: .init(width: .zero, height: 20))
        setupNavigationBar()
        setupSearchBar()
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
        definesPresentationContext = true
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.75)])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        if searchTerm == "" {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                self.enterSearchLabel.isHidden = false
            }
            return
        }
        
        performSearch(searchTerm: searchTerm)
    }
    
    func performSearch(searchTerm: String) {
        ApiService.shared.searchMovies(searchTerm: searchTerm) { (result) in
            switch result {
            case .failure(let error):
                print("error in service...", error)
            case .success(let fetchResult):
                self.movies = fetchResult.results ?? []
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! MovieSearchCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = MovieDetailsController(collectionViewLayout: UICollectionViewFlowLayout())
        detailsController.movie = movies[indexPath.item]
        present(detailsController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        enterSearchLabel.isHidden = movies.count == 0 ? false : true
        
        return movies.count
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = []
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 150)
    }
    
}
