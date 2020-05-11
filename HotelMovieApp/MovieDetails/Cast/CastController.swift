//
//  CastController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class CastController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let castcellid = "castcellid"
    
    var movieCastMembers: [CastMember]?
    
    var movie: Movie? {
        didSet {
            fetchCastMembers()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CastMemberCell.self, forCellWithReuseIdentifier: castcellid)
    }
    
    fileprivate func fetchCastMembers() {
        guard let movieId = movie?.id else { return }
        Service.shared.fetchCredits(movieId: movieId) { (result) in
            switch result {
            case .failure(let error):
                print("Error in cast fetching, ", error)
            case .success(let data):
                guard let cast = data.cast else { return }
                self.movieCastMembers = cast
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieCastMembers?.count ?? 0 > 20 {
            return 20
        }
        return movieCastMembers?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castcellid, for: indexPath) as! CastMemberCell
        cell.castMember = movieCastMembers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthHeight = view.frame.height - 40
        return .init(width: widthHeight, height: widthHeight)
    }
    
}
