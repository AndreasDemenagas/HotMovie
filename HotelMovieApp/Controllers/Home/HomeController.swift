//
//  HomeController.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit
import FirebaseAuth

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let homeSectionCellId = "homecellid"
    
    fileprivate let sectionTitles = ["Now Playing", "Top Rated", "Popular", "Upcoming"]
    
    var nowPlayingMovies = [Movie]()
    var upcomingMovies = [Movie]()
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        collectionView.register(HomeControllerCell.self, forCellWithReuseIdentifier: homeSectionCellId)
        collectionView.contentInset = .init(top: 16, left: 0, bottom: 24, right: 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(handleSignOut))
        
        checkForUserSignedIn()
        
        fetchHomeFeedSections()
    }
    
    func checkForUserSignedIn() {
        if Auth.auth().currentUser?.uid == nil {
            print("no user signed in...")
            perform(#selector(performLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleSignOut() {
        Alert.shared.signOutConfirm(on: self) { [weak self] (action) in
            guard let title = action.title else { return }
            
            if title == "Log out" {
                self?.performLogout()
            }
        }
    }
    
    @objc func performLogout() {
        do {
            try Auth.auth().signOut()
        }
            
        catch let error {
            print("logout error, ", error)
        }
        
        let loginController = LoginController()
        loginController.isModalInPresentation = true
        present(loginController, animated: true, completion: nil)
    }
    
    func fetchHomeFeedSections() {
        fetchNowPlaying()
        fetchUpcoming()
        fetchPopular()
        fetchTopRated()
    }
    
    func fetchPopular() {
        ApiService.shared.fetchPopular { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("upcoming error ", error)
            case .success(let response):
                self?.popularMovies = response.results ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    func fetchUpcoming() {
        ApiService.shared.fetchUpcoming { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("upcoming movies error ", error)
            case .success(let response):
                self?.upcomingMovies = response.results ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    func fetchNowPlaying() {
        ApiService.shared.fetchNowPlaying { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("now playing error ", error)
            case .success(let response):
                self?.nowPlayingMovies = response.results ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    func fetchTopRated() {
        ApiService.shared.fetchTopRated { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("top rated error happened", error)
            case .success(let response):
                self?.topRatedMovies = response.results ?? []
                self?.collectionView.reloadData()
            }
        }
    }
    
    func showDetails(detailsController: MovieDetailsController) {
        present(detailsController, animated: true, completion: nil)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeSectionCellId, for: indexPath) as! HomeControllerCell
        cell.sectionLabelText = sectionTitles[indexPath.item]
        cell.homeController = self 
        
        if indexPath.item == 0 {
            cell.movies = nowPlayingMovies
        }
        
        if indexPath.item == 1 {
            cell.movies = topRatedMovies
        }
        
        if indexPath.item == 2 {
            cell.movies = popularMovies
        }
        
        if indexPath.item == 3 {
            cell.movies = upcomingMovies
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250 + 20 + 12 + 4)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
}
