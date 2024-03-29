//
//  ReviewCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 12/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        v.layer.cornerRadius = 5
        return v
    }()
    
    let reviewerNameLabel = UILabel(text: "We are sorry :(", textColor: .lightGray, font: .boldSystemFont(ofSize: 16))
    
    let textLabel: UILabel = {
        let l =  UILabel(text: "The are no reviews available for this movie", textColor: .lightGray, font: .systemFont(ofSize: 16), alignment: .justified, numberOfLines: 0)
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    lazy var readFullLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Read Full Review"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        lbl.isHidden = true
//        lbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReadFullReview)))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var review: Review? {
        didSet {
            readFullLabel.isHidden = false
            reviewerNameLabel.text = "By: \(review?.author ?? "No reviews...")"
            
            let modifiedText = review?.content.replacingOccurrences(of: "\r\n\r\n", with: " ")
            
            textLabel.text = modifiedText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews() {
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 0, bottom: 6, right: 12), size: .zero)
        
        addSubview(reviewerNameLabel)
        reviewerNameLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 6, left: 16, bottom: 0, right: 6), size: .init(width: .zero, height: 20))
        
        addSubview(readFullLabel)
        readFullLabel.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 0), size: .init(width: .zero, height: 20))
        
        addSubview(textLabel)
        textLabel.anchor(top: reviewerNameLabel.bottomAnchor, leading: reviewerNameLabel.leadingAnchor, bottom: readFullLabel.topAnchor, trailing: reviewerNameLabel.trailingAnchor, padding: .init(top: 4, left: 0, bottom: 6, right: 6), size: .zero)
    }
    
}
