//
//  HomeMovieCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/7/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
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
            let urlString = "https://image.tmdb.org/t/p/w500/\(movie.poster_path ?? "")"
            posterImageView.loadImageFromCacheOrDownload(urlString: urlString)
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
        addSubview(posterImageView)
        posterImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
}
