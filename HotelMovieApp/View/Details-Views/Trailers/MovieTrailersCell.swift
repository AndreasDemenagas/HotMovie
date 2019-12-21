//
//  MovieTrailersCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 17/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerCell: UITableViewCell {
    
    let lineView = UIView()
    let webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()
    
    var video: MovieVideo? {
        didSet {
            guard let videoKey = video?.key else { return }
            let urlString = "https://www.youtube.com/embed/\(videoKey)"
            guard let url = URL(string: urlString) else { return }
            let request  = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    var movieTrailersController: MovieTrailersController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        lineView.backgroundColor = .darkGray
        
        addSubview(webView)
        webView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
