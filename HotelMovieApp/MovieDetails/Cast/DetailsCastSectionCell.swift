//
//  DetailsCastSectionCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class MovieDetailsCastSectionCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
           castController.movie = movie
        }
    }
    
    let topLine = UIView(backgroundColor: .lightGray)
    
    let actorsLabel = UILabel(text: "Actors", font: .boldSystemFont(ofSize: 22))
    
    lazy var castController: CastController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        let vc = CastController(collectionViewLayout: layout)
        return vc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topLine)
        topLine.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 16, bottom: 0, right: 16), size: .init(width: .zero, height: 1))
        
        addSubview(actorsLabel)
        actorsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 16, bottom: 0, right: 0), size: .init(width: .zero, height: 20))
        
        addSubview(castController.view)
        castController.view.anchor(top: actorsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
