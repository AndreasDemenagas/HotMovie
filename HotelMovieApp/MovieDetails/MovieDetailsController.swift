//
//  MovieDetailsController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 9/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class MovieDetailsController: UICollectionViewController {
    
    fileprivate let posterHeaderId = "posterHeaderId"
    fileprivate let infoCellId = "infocellid"
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(DetailsPosterHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: posterHeaderId)
        collectionView.register(DetailsInfoCell.self, forCellWithReuseIdentifier: infoCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: posterHeaderId, for: indexPath) as! DetailsPosterHeader
        header.delegate = self
        header.posterPath = movie?.poster_path
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! DetailsInfoCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}


// MARK: DelegateFlowLayout
extension MovieDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width * 1.5)
    }
    
}

// MARK: Custom Delegation
extension MovieDetailsController: DetailsHeaderDelegate {
    func didCancel() {
        dismiss(animated: true, completion: nil)
    }
}
