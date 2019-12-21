//
//  MovieTrailersCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 17/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit

class MovieTrailerCell: UITableViewCell {
    
    let greeView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
        
        greeView.backgroundColor = .green
        addSubview(greeView)
        greeView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 25, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
