//
//  ReviewsController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 12/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ReviewsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let reviewcell = "reviewcellid"
    
    var reviews: [Review]?
    
    var movie: Movie? {
        didSet {
            if reviews == nil {
                fetchMovieReviews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewcell)
    }
    
    fileprivate func fetchMovieReviews() {
        guard let movieId = movie?.id else { return }
        Service.shared.fetchReviews(movieId: movieId) { (networkResponse) in
            switch networkResponse {
            case .failure(let error):
                print("Error fetching reviews, ", error)
            case .success(let data):
                self.reviews = data.results
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if reviews?.count == 0 {
            return 1
        }
        return reviews?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewcell, for: indexPath) as! ReviewCell
        if reviews?.count == 0 {
            return reviewCell
        }
        reviewCell.review = reviews?[indexPath.item]
        return reviewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 35 , height: view.frame.height)
    }
    
}
