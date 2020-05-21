//
//  AddToListFooter.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 12/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class AddToListFooter: UICollectionReusableView {
    
    let addToListLabel = UILabel(text: "Add this to your list", font: .boldSystemFont(ofSize: 22))
    
    lazy var addButton: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "heart-white").withRenderingMode(.alwaysTemplate))
        imgView.tintColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAddToList)))
        return imgView
    }()
    
    var movie: Movie? {
        didSet {
            fetchIfInList()
        }
    }
    
    var isInList: Bool?
    
    weak var delegate: AddToListDelegate? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(addButton)
        addButton.constantSize(width: 30, height: 30)
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        addSubview(addToListLabel)
        addToListLabel.fillSuperView(padding: .init(top: 0, left: 16, bottom: 0, right: 66))
    }
    
    fileprivate func fetchIfInList() {
        if isInList != nil {
            return
        }
        
        guard let movieId = movie?.id else { return }
        FIRService.shared.checkIfMovieInList(movieId: String(movieId)) { (value) in
            
            if value == 1 {
                self.isInList = true
                self.setupImageAndLabel()
                return
            }
            
            self.isInList = false
            self.setupImageAndLabel()
        }
    }
    
    fileprivate func setupImageAndLabel() {
        assert(isInList != nil, "Can't pass nil isInList")
        
        if isInList! {
            addToListLabel.text = "Already in list"
            addButton.image = UIImage(named: "heart-filled-red")
        }
    }
    
    @objc fileprivate func handleTapAddToList() {
        delegate?.didTapAddToList()
        UIView.animate(withDuration: 0.3) {
            self.addButton.image = UIImage(named: "heart-filled-red")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
