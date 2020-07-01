//
//  DetailsInformationCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 9/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class DetailsInfoCell: UICollectionViewCell {
    
    let movieTitleLabel = UILabel(text: "Star Wars: The Rise of Skywalker", font: .boldSystemFont(ofSize: 22), numberOfLines: 2)
    
    let releasedLabel = UILabel(text: "Released: Dec 21, 2020", textColor: .lightGray, font: .systemFont(ofSize: 16), numberOfLines: 1)
    
    let ratingLabel = UILabel(text: "Rating: 5.0/10", textColor: .lightGray, font: .systemFont(ofSize: 16), numberOfLines: 1)
    
    let plotLabel = UILabel(text: "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order.", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    let separatorLine = UIView(backgroundColor: .white)
    
    lazy var trailerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Watch Trailers", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(handleShowTrailers), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            releasedLabel.formatAndShowDate(dateString: movie.release_date, formatString: "MMMM dd, yyyy")
            plotLabel.text = movie.overview ?? ""
            ratingLabel.text = "Rating: \(movie.vote_average ?? 0)/10"
        }
    }
    
    weak var trailersDelegate: TrailersDelegate? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    @objc private func handleShowTrailers() {
        trailersDelegate?.didTapShowTrailers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCell() {
        let stack = UIStackView(arrangedSubviews:[movieTitleLabel, releasedLabel, plotLabel,  trailerBtn, ratingLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 6
        
        addSubview(stack)
        stack.fillSuperView(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    
}
