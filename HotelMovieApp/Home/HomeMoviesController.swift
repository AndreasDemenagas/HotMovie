//
//  MoviesController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 13/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeMoviesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let movieCellID = "movieCellidhome"
    
    var movies: [Movie]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var homeDelegate: HomeFeedDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.scrollIndicatorInsets = .init(top: 0, left: 24, bottom: 0, right: 0)
        collectionView.register(HomeMovieCell.self, forCellWithReuseIdentifier: movieCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies?[indexPath.item]
        homeDelegate?.didTapHomeMovie(movie: movie)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellID, for: indexPath) as! HomeMovieCell
        cell.movie = movies?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.height / 1.5, height: view.frame.height)
    }
    
    
}
