//
//  SearchCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    let separatorLine = UIView(backgroundColor: .white)
    
    let movieTitleLabel = UILabel(text: "", textColor: .white, font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    
    let detailsLabel = UILabel(text: "Released: 2019", textColor: .lightGray, font: .systemFont(ofSize: 16))
    
    let posterImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "mad-max-poster"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        imgView.layer.borderWidth = 1
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            detailsLabel.formatAndShowDate(dateString: movie.release_date, formatString: "MMM dd YYYY")
            
            if let posterPath = movie.poster_path {
                let urlString = Service.smallImageUrl + posterPath
                posterImageView.loadImageFromCacheOrDownload(urlString: urlString)
                return
            }
            
            posterImageView.image = nil
            posterImageView.backgroundColor = .lightGray
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        setupCell()
    }
    
    func setupCell() {
        posterImageView.constantSize(width: 100, height: 100)
        
        let labelStack = UIStackView(arrangedSubviews: [movieTitleLabel, detailsLabel])
        labelStack.spacing = 10
        labelStack.axis = .vertical
        
        let stack = UIStackView(arrangedSubviews: [posterImageView, labelStack])
        stack.spacing = 10
        stack.alignment = .center
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 32, bottom: 16, right: 32))
        
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: stack.leadingAnchor, bottom: bottomAnchor, trailing: stack.trailingAnchor, size: .init(width: .zero, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

