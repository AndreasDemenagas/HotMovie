//
//  HomeMovieCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 13/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeMovieCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "mad-max-poster"))
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        imgView.layer.borderWidth = 1
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        return imgView
    }()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
                
            guard let posterPath = movie.poster_path else {
                posterImageView.image = UIImage(named: "no-image")
                return
            }
            
            let urlString = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            posterImageView.loadImageFromCacheOrDownload(urlString: urlString)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
