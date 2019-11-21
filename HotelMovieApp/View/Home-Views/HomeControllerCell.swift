//
//  HomeControllerCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/7/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class HomeControllerCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    fileprivate let homeMovieCellid = "homeMovieCellid"
    
    let sectionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Now Playing"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        return lbl
    }()
    
    var sectionLabelText: String? {
        didSet {
            sectionTitleLabel.text = sectionLabelText
        }
    }
    
    var movies: [Movie]? {
        didSet {
            moviesCollectionView.reloadData()
        }
    }
    
    var homeController: HomeController? 
    
    lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.register(HomeMovieCell.self, forCellWithReuseIdentifier: homeMovieCellid)
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets.init(top: 0, left: 24, bottom: 0, right: 0)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews() {
        addSubview(sectionTitleLabel)
        sectionTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 12), size: .init(width: .zero, height: 20))
        addSubview(moviesCollectionView)
        moviesCollectionView.anchor(top: sectionTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsController = MovieDetailsController(collectionViewLayout: UICollectionViewFlowLayout())
        detailsController.movie = movies?[indexPath.item]
        homeController?.showDetails(detailsController: detailsController)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: homeMovieCellid, for: indexPath) as! HomeMovieCell
        movieCell.movie = movies?[indexPath.item]
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: moviesCollectionView.frame.height / 1.5, height: moviesCollectionView.frame.height)
    }
    
    
}
