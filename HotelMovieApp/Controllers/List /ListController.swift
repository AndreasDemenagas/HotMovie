//
//  ListController.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit
import Firebase

class ListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let profileHeaderId = "profileHeaderid"
    fileprivate let listcellid = "listcellid"
    fileprivate let noItemsLabel: UILabel = {
        let label = UILabel()
        label.text = "You have no items in your list.\nPlease add one"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()

    
    var user: UserModel?
    
    var movies: [Movie]? {
        didSet {
            noItemsLabel.isHidden = true
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        collectionView.register(ListProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderId)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: listcellid)
        collectionView.contentInset = .init(top: 24, left: 12, bottom: 24, right: 12)
        collectionView.alwaysBounceVertical = true
        
        setupNoItemsLabel()
        fetchCurrentUser()
        
        fetchUserList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(123123)
        fetchUserList()
    }
    
    fileprivate func fetchUserList() {
        print("fetching the list of the user...")
        FirebaseService.shared.fetchUserList { movies in
            self.movies = movies
        }
    }
    
    fileprivate func setupNoItemsLabel() {
        collectionView.addSubview(noItemsLabel)
        noItemsLabel.anchor(top: collectionView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 148, left: 32, bottom: 0, right: 32), size: .init(width: .zero, height: 60))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            self.user = UserModel(with: dictionary)
            
            self.collectionView.reloadData()
            
        }, withCancel: nil)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
                     navigationController?.navigationBar.tintColor = .white
                     
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
         navigationController?.navigationBar.titleTextAttributes = textAttributes
         navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listcellid, for: indexPath) as! ListCell
        cell.movie = movies?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width / 2) - 10 - 24
        
        return .init(width: width, height: width*1.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: profileHeaderId, for: indexPath) as! ListProfileHeaderView
        profileHeader.user = user
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 100)
    }
    
}
