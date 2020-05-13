//
//  HomeController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController {
    
    fileprivate let homeRowCellId = "homecellid"
    
    fileprivate let sectionTitles = ["Now Playing", "Popular", "Upcoming", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(handleSignOut))
        collectionView.register(HomeRowSectionCell.self, forCellWithReuseIdentifier: homeRowCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserSignedIn()
    }
    
    fileprivate func checkIfUserSignedIn() {
        if FIRService.shared.getCurrentUserId() == nil {
            performLogOut()
        }
    }
    
    @objc func handleSignOut() {
        self.performLogOut()
    }
    
    fileprivate func performLogOut() {
        FIRService.shared.logoutUser { [weak self] (error)  in
            if let error = error {
                print("logout error", error)
                return
            }
            
            let loginController = LoginController()
            loginController.isModalInPresentation = true
            self?.present(loginController, animated: true)
        }
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowCell = collectionView.dequeueReusableCell(withReuseIdentifier: homeRowCellId, for: indexPath) as! HomeRowSectionCell
        rowCell.sectionTitle = sectionTitles[indexPath.item]
        return rowCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
}
