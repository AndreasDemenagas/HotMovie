//
//  MovieDetailsCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/4/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class MovieDetailsCell: UICollectionViewCell {
    
    let movieTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Star Wars: The Force Awakens Star Wars: The Force Awakens"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = .white
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let releasedLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Released: Dec 15, 2017"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rating: 7.6/10"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    let plotLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order."
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let separatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var trailerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Watch Trailers", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.green, for: .normal)
        btn.addTarget(self, action: #selector(handleShowTrailers), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func handleShowTrailers() {
        print("showing trailers...")
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            releasedLabel.formatAndShowDate(dateString: movie.release_date, formatString: "MMMM dd, yyyy")
            plotLabel.text = movie.overview ?? ""
            ratingLabel.text = "Rating: \(movie.vote_average ?? 0)/10"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createPlotString(string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        attributedString.append(NSAttributedString(string: " \n \nWatch Trailers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
        
        return attributedString
    }
    
    fileprivate func setupCell() {
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        releasedLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        trailerBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, releasedLabel, plotLabel,  trailerBtn, ratingLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading

        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: .zero, height: frame.height - 12))
        
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: .zero, height: 1))
    }
    
}
