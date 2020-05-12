//
//  ReviewsSectionCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 12/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ReviewsSectionCell: UICollectionViewCell {
    
    let reviewsLabel = UILabel(text: "Reviews", font: .boldSystemFont(ofSize: 22))
    
    lazy var reviewsController: ReviewsController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        let vc = ReviewsController(collectionViewLayout: layout)
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPink
        
        addSubview(reviewsLabel)
        reviewsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 16, bottom: 0, right: 0), size: .init(width: .zero, height: 20))
        
        addSubview(reviewsController.view)
        reviewsController.view.anchor(top: reviewsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
