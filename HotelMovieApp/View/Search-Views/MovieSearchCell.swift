//
//  MovieSearchCell.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class MovieSearchCell: UICollectionViewCell {
    
    let separatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
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
    
    let movieTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Star Wars: The Last Jedi tii5jti"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let detailsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Released: 2017"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie, let posterPath = movie.poster_path else { return }
            movieTitleLabel.text = movie.title
            
            let posterUrlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
            posterImageView.loadImageFromCacheOrDownload(urlString: posterUrlString)
    
            detailsLabel.formatAndShowDate(dateString: movie.release_date, formatString: "MMM, dd YYYY")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupCell() {
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32), size: .init(width: .zero, height: 2))
        
        posterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let verticalStackView = UIStackView(arrangedSubviews: [movieTitleLabel, detailsLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 6
        
        let stackView = UIStackView(arrangedSubviews: [posterImageView, verticalStackView])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 32, bottom: 16, right: 32))
    }
    
}
