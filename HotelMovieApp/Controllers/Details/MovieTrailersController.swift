//
//  MovieTrailersController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 17/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit

class MovieTrailersController: UITableViewController {
    
    fileprivate let trailerCellid = "trailercellid"
    
    var movieVideos: [MovieVideo]?
    
    fileprivate let noTrailersLabel: UILabel = {
        let label = UILabel()
        label.text = "There are no available trailers for this movie..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movie: Movie? {
        didSet {
            guard let id = movie?.id else { return }
            fetchVideos(movieId: id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.95)
        navigationController?.navigationBar.prefersLargeTitles = true 
        navigationItem.title = "Trailers"
        
        setupNavigationBar()
        setupNoTrailersLabel()
        
        tableView.allowsSelection = false
        tableView.register(MovieTrailerCell.self, forCellReuseIdentifier: trailerCellid)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    func fetchVideos(movieId: Int) {
        ApiService.shared.fetchMovieVideos(id: movieId) { (response) in
            switch response {
            case .failure(let error):
                print("error in video download", error)
            case .success(let res):
                self.filterMovieVideos(videos: res.results ?? [])
            }
        }
    }
    
    func filterMovieVideos(videos: [MovieVideo]) {
        noTrailersLabel.isHidden = true
        
        if videos.count == 0 {
            noTrailersLabel.isHidden = false
            return
        }
        
        movieVideos = videos.filter({ (video) -> Bool in
            video.site == "YouTube" && (video.type == "Trailer" || video.type == "Teaser")
        })
        tableView.reloadData()
    }
    
    fileprivate func setupNoTrailersLabel() {
        view.addSubview(noTrailersLabel)
        noTrailersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        noTrailersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTrailersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        noTrailersLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width / 1.777777 + 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trailerCellid) as! MovieTrailerCell
        cell.video = movieVideos?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVideos?.count ?? 0 
    }
    
}
