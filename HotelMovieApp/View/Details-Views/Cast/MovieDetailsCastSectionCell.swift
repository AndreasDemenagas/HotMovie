//
//  MovieDetailsCastCell.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class MovieDetailsCastSectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate let castCellid = "castCelliddd"
    
    let actorsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Actors"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = .white
        return lbl
    }()
    
    lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.register(ActorCastCell.self, forCellWithReuseIdentifier: castCellid)
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return cv
    }()
    
    var movieCastMembers: [CastMember]? {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupCell() {
        addSubview(actorsLabel)
        actorsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 18, left: 12, bottom: 0, right: 0), size: .init(width: .zero, height: 20))
        
        addSubview(castCollectionView)
        castCollectionView.anchor(top: actorsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieCastMembers?.count ?? 0 > 20 {
            return 20
        }
        return movieCastMembers?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: castCellid, for: indexPath) as! ActorCastCell
        cell.castMember = movieCastMembers?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthHeight = castCollectionView.frame.height - 40
        return .init(width: widthHeight, height: widthHeight)
    }
    
}
