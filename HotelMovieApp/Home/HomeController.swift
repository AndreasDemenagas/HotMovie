//
//  HomeController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, HomeFeedDelegate {
    
    fileprivate let homeRowCellId = "homecellid"
    
    fileprivate let sectionTitles = ["Now Playing", "Popular", "Upcoming", "Top Rated"]
    
    var nowPlayingMovies = [Movie]()
    var upcomingMovies = [Movie]()
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(handleSignOut))
        collectionView.register(HomeRowSectionCell.self, forCellWithReuseIdentifier: homeRowCellId)
        collectionView.contentInset = .init(top: 24, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = .init(top: 24, left: 0, bottom: 0, right: 0)
        
        fetchHomeSections()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserSignedIn()
    }
    
    func fetchHomeSections() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchNowPlaying {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchPopular {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchUpcoming {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchTopRated {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func fetchPopular(completion: @escaping () -> ()) {
        Service.shared.fetchPopular { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("upcoming error ", error)
            case .success(let response):
                self?.popularMovies = response.results ?? []
                completion()
            }
        }
    }
    
    func fetchUpcoming(completion: @escaping () -> ()) {
        Service.shared.fetchUpcoming { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("upcoming movies error ", error)
            case .success(let response):
                self?.upcomingMovies = response.results ?? []
                completion()
            }
        }
    }
    
    func fetchNowPlaying(completion: @escaping () -> ()) {
        Service.shared.fetchNowPlaying { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("now playing error ", error)
            case .success(let response):
                self?.nowPlayingMovies = response.results ?? []
                completion()
            }
        }
    }
    
    func fetchTopRated(completion: @escaping () -> ()) {
        Service.shared.fetchTopRated { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("top rated error happened", error)
            case .success(let response):
                self?.topRatedMovies = response.results ?? []
                completion()
            }
        }
    }
    
    fileprivate func checkIfUserSignedIn() {
        if FIRService.shared.getCurrentUserId() == nil {
            performLogOut()
        }
    }
    
    @objc func handleSignOut() {
        Alerts.shared.signOutConfirm(on: self) { [weak self] (action) in
            if let title = action.title, title == "Log out" {
                self?.performLogOut()
                return
            }
        }
    }
    
    func didTapHomeMovie(movie: Movie?) {
        let detailsController = MovieDetailsController(collectionViewLayout: UICollectionViewFlowLayout())
        detailsController.movie = movie
        present(detailsController, animated: true)
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
        rowCell.homeDelegate = self 
        
        if indexPath.item == 0 {
            rowCell.movies = nowPlayingMovies
        }
        
        if indexPath.item == 1 {
            rowCell.movies = popularMovies
        }
        
        if indexPath.item == 2 {
            rowCell.movies = upcomingMovies
        }
        
        if indexPath.item == 3 {
            rowCell.movies = topRatedMovies
        }
        
        return rowCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("RELOADING")
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 270)
    }
    
}
