//
//  DetailPosterHeader.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/4/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class DetailsPosterHeader: UICollectionReusableView {
    
    let posterImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "mad-max-poster"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        imgView.layer.borderWidth = 1
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        return imgView
    }()
    
    lazy var cancelButton: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "icons8-close-window-50"))
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        imgView.layer.shadowColor = UIColor.white.cgColor
        imgView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        imgView.layer.shadowOpacity = 0.5
        imgView.layer.shadowRadius = 4.0
        return imgView
    }()
    
    var detailsController: MovieDetailsController? 
    
    @objc func handleDismiss() {
        detailsController?.handleClose()
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = movie, let posterPath = movie.poster_path else { return }
            let urlString = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            posterImageView.loadImageFromCacheOrDownload(urlString: urlString)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupHeader() {
        let posterWidth = frame.width - 20
        let posterHeight = posterWidth * 1.5
        
        addSubview(posterImageView)
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: posterWidth).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: posterHeight).isActive = true
        
        addSubview(cancelButton)
        cancelButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 24), size: .init(width: 50, height: 50))
    }
    
    
}
