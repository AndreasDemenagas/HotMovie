//
//  MovieTrailerCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerCell: UITableViewCell {
    
    let lineView = UIView(backgroundColor: .darkGray)
    
    let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .audio
        let wv = WKWebView(frame: .zero, configuration: configuration)
        return wv
    }()
    
    let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var playButtonImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "play-button"))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePlay)))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var video: MovieVideo? {
        didSet {
            guard let videoKey = video?.key else { return }
            let thumbnailUrlString = "https://i1.ytimg.com/vi/\(videoKey)/maxresdefault.jpg"
            thumbnailImageView.loadImageFromCacheOrDownload(urlString: thumbnailUrlString)
        }
    }
    
    @objc fileprivate func handlePlay() {
        webView.loadWithYouTubeKey(key: video?.key) {
            
        }
        
        thumbnailImageView.isHidden = true
        playButtonImageView.isUserInteractionEnabled = false
        playButtonImageView.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        
        setupCell()
    }
    
    fileprivate func setupCell() {
        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 1))
        
        addSubview(webView)
        webView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        
        addSubview(thumbnailImageView)
        thumbnailImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        addSubview(playButtonImageView)
        playButtonImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButtonImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playButtonImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playButtonImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WKWebView {
    
    func loadWithYouTubeKey(key: String?, completion: () -> () ) {
        guard let videoKey = key else { return }
        let urlString = "https://www.youtube.com/embed/\(videoKey)"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        let request  = URLRequest(url: url)
        self.load(request)
        
        completion()
    }
    
}
