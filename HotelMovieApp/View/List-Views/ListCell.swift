//
//  ListCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 10/5/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "kqjL17yufvn9OVLyXYpvtyrFfak"))
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
            guard let posterPath = movie?.poster_path else {
                print("no path")
                return
            }
            let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            posterImageView.loadImageFromCacheOrDownload(urlString: urlString)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let padding: CGFloat = 0
        
        addSubview(posterImageView)
        posterImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding), size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
