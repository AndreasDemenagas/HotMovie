//
//  ListCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 14/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "mad-max-poster"))
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        imgView.layer.borderWidth = 1
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImageView)
        posterImageView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
