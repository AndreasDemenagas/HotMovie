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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewcell)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewcell, for: indexPath) as! ReviewCell
        return reviewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 35 , height: view.frame.height)
    }
    
}
