//
//  DetailsAddToLIstFooter.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/9/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit 

class DetailsFooter: UICollectionReusableView {
    
    let addToListLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Add this to your list"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var addButton: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "photoPlusButton").withRenderingMode(.alwaysTemplate))
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .white
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddToList)))
        imgView.layer.shadowColor = UIColor.lightGray.cgColor
        imgView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        imgView.layer.shadowOpacity = 0.5
        imgView.layer.shadowRadius = 4.0
        return imgView
    }()
    
    var movie: Movie?
    
    @objc func handleAddToList() {
        FirebaseService.shared.addMovieToList(movieId: movie?.id ?? 0) {
            self.addButton.image = #imageLiteral(resourceName: "checkmark-icon")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews() {
        addSubview(addToListLabel)
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [addToListLabel, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 24), size: .zero)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
