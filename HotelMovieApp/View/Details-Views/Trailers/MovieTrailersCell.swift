//
//  MovieTrailersCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 17/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit

class MovieTrailerCell: UITableViewCell {
    
    let thumbnailImageView = UIImageView()
    let lineView = UIView()
    
    let playButton: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "play-button"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var video: MovieVideo? {
        didSet {
            let urlString = "https://i1.ytimg.com/vi/\(video?.key ?? "")/maxresdefault.jpg"
            
            
            thumbnailImageView.loadImageFromCacheOrDownload(urlString: urlString)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        lineView.backgroundColor = .darkGray
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 1))

        addSubview(thumbnailImageView)
        thumbnailImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        addSubview(playButton)
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playButton.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true
        playButton.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
