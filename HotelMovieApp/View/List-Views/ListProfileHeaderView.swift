//
//  ListProfileHeaderView.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class ListProfileHeaderView: UICollectionReusableView {
    
    let profileImageView: UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "obiwan copy"))
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 25
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.borderWidth = 1
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        let attributedString = NSMutableAttributedString(string: "Welcome back, ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        attributedString.append(NSAttributedString(string: "Andrew BrickMovies", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        lbl.attributedText = attributedString
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let separatorLine: UIView = {
        let v = UIView()
        v.backgroundColor = .darkGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var user: UserModel? {
        didSet {
            let attributedString = NSMutableAttributedString(string: "Welcome back, ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            attributedString.append(NSAttributedString(string: user?.username ?? "no_name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
            userNameLabel.attributedText = attributedString
            
            profileImageView.loadImageFromCacheOrDownload(urlString: user?.profileImageUrl ?? "")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    fileprivate func setupViews() {
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 24, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        
        addSubview(userNameLabel)
        userNameLabel.anchor(top: nil, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: .zero, height: 50))
        userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: .zero, height: 1))
    }
    
}

