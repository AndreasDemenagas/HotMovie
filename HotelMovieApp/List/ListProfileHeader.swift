//
//  ListProfileHeader.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 16/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ListProfileHeader: UICollectionReusableView {
    
    let separatorLine = UIView(backgroundColor: .darkGray)
    
    let usernameLabel = UILabel()
    
    var user: UserM? {
        didSet {
            let attributedString = NSMutableAttributedString(string: "Welcome back, ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            attributedString.append(NSAttributedString(string: user?.username ?? "no_name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
            usernameLabel.attributedText = attributedString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(usernameLabel)
        usernameLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 50))
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 1))
    }
    
}
