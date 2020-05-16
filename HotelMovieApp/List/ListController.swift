//
//  ListController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 14/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class ListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let listCellid = "listcellid"
    fileprivate let profileListHeaderid = "profileListHeaderid"
    
    fileprivate let noItemsLabel: UILabel = {
        let label = UILabel(text: "You have no items in your list.\nPlease add one", font: .boldSystemFont(ofSize: 20), alignment: .center, numberOfLines: 0)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var user: UserM? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        //setupNoItemsLabel()
        
        collectionView.contentInset = .init(top: 24, left: 24, bottom: 24, right: 24)
        collectionView.scrollIndicatorInsets = .init(top: 24, left: 0, bottom: 0, right: 0)
        
        collectionView.register(ListProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileListHeaderid)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: listCellid)
        
        fetchCurrentUser()
    }
    
    fileprivate func fetchCurrentUser() {
        FIRService.shared.fetchCurrentUser { (result) in
            switch result {
            case .failure(let error):
                print("Failed to fetch current user ", error)
            case .success(let user):
                self.user = user 
            }
        }
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    fileprivate func setupNoItemsLabel() {
        view.addSubview(noItemsLabel)
        noItemsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 48, left: 16, bottom: 0, right: 0), size: .init(width: view.frame.width - 32, height: 50))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellid, for: indexPath) as! ListCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 38
        return .init(width: width, height: width*1.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 35, left: 0, bottom: 0, right: 0)
    }
    
    
    //MARK: Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileListHeaderid, for: indexPath) as! ListProfileHeader
        header.user = user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 65)
    }
    
}
