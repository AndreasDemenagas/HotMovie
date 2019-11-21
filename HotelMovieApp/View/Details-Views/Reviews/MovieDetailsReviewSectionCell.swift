//
//  MovieDetailsReviewSectionCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/9/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class MovieDetailsReviewSectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate let reviewCellid = "reviewcelliddd"
    
    var detailsController: MovieDetailsController?
    
    let reviewsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Reviews"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var reviewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        cv.delegate = self
        cv.dataSource = self
        cv.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellid)
        return cv
    }()
    
    var movieReviews: [Review]? {
        didSet {
            self.reviewsCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews() {
        addSubview(reviewsLabel)
        reviewsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 12, bottom: 0, right: 0), size: .init(width: .zero, height: 20))
        
        addSubview(reviewsCollectionView)
        reviewsCollectionView.anchor(top: reviewsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 0, bottom: 0, right: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieReviews?.count == 0 {
            return 1
        }
        return movieReviews?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if movieReviews?.count == 0 {
            return .init(width: frame.width - 35, height: 100)
        }
        
        return .init(width: frame.width - 35, height: reviewsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewCell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: reviewCellid, for: indexPath) as! ReviewCell
        
        if movieReviews?.count == 0 {
            return reviewCell
        }
        
        reviewCell.movieDetailsController = detailsController
        reviewCell.review = movieReviews?[indexPath.item]
        return reviewCell
    }
    
    
}
