//
//  ActorCastCell.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/6/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class ActorCastCell: UICollectionViewCell {
    
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
    
    let actorNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mark Hamill "
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var castMember: CastMember? {
        didSet {
            guard let profileUrl = castMember?.profile_path, let person = castMember else { return }
            let urlString = "https://image.tmdb.org/t/p/w500/\(profileUrl)"
            actorImageView.loadImageFromCacheOrDownload(urlString: urlString)
            actorNameLabel.text = person.name ?? ""
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
        actorNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        actorImageView.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
        let stack = UIStackView(arrangedSubviews: [actorImageView, actorNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
    
}
