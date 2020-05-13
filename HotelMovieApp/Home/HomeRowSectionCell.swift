//
//  HomeRowSectionCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 13/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeRowSectionCell: UICollectionViewCell {
    
    let sectionTitleLbl = UILabel(text: "Upcoming", font: .boldSystemFont(ofSize: 20))
    
    let moviesController: HomeMoviesController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 0)
        let controller = HomeMoviesController(collectionViewLayout: layout)
        return controller
    }()
    
    var sectionTitle: String? {
        didSet {
            sectionTitleLbl.text = sectionTitle
        }
    }
    
    weak var homeDelegate: HomeFeedDelegate? {
        didSet {
            moviesController.homeDelegate = homeDelegate
        }
    }
    
    var movies: [Movie]? {
        didSet {
            guard let movies = movies else { return }
            moviesController.movies = movies
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupCell() {
        addSubview(sectionTitleLbl)
        sectionTitleLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 12), size: .init(width: .zero, height: 20))
        
        addSubview(moviesController.view)
        moviesController.view.anchor(top: sectionTitleLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
}
