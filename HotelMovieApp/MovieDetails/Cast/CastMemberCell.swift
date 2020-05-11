//
//  CastMemberCell.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class CastMemberCell: UICollectionViewCell {
    
    let nameLabel = UILabel(text: "Mark Hamill", textColor: .lightGray, font: .systemFont(ofSize: 16))
    
    let actorImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "obiwan copy"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        imgView.layer.borderWidth = 1
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    var castMember: CastMember? {
        didSet {
            guard let castMember = castMember else { return }
            nameLabel.text = castMember.name ?? ""
            
            if let profileImageUrl = castMember.profile_path {
                let urlString = "https://image.tmdb.org/t/p/w500/\(profileImageUrl)"
                actorImageView.loadImageFromCacheOrDownload(urlString: urlString)
                return
            }
            
            actorImageView.image = UIImage(named: "no-image")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    fileprivate func setupCell() {
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        actorImageView.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
        let stack = UIStackView(arrangedSubviews: [actorImageView, nameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
