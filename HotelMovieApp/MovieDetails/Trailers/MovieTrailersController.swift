//
//  MovieTrailersController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit 

class MovieTrailersController: UITableViewController {
    
    fileprivate let noTrailersLabel = UILabel(text: "There are no available trailers for this movie...", font: .boldSystemFont(ofSize: 20), alignment: .center, numberOfLines: 0)
    
    fileprivate let trailerCellid = "trailercellid"
    
    var movie: Movie? {
        didSet {
            guard let id = movie?.id else { return }
            fetchMovieVideos(id)
        }
    }
    
    var movieVideos: [MovieVideo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.95)
        setupNavigationBar()
        setupNoTrailersLabel()
        
        tableView.register(MovieTrailerCell.self, forCellReuseIdentifier: trailerCellid)
    }
    
    fileprivate func setupNoTrailersLabel() {
        tableView.addSubview(noTrailersLabel)
        noTrailersLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 32, left: 16, bottom: 0, right: 0), size: .init(width: view.frame.width - 32, height: 50))
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Trailers"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    private func fetchMovieVideos(_ movieId: Int) {
        Service.shared.fetchMovieVideos(for: movieId) { (response) in
            switch response {
            case .failure(let error):
                print("Fetching videos error, ", error)
            case .success(let res):
                self.filterMovieVideos(videos: res.results ?? [])
            }
        }
    }
    
    private func filterMovieVideos(videos: [MovieVideo]) {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trailerCellid) as! MovieTrailerCell
        cell.video = movieVideos?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVideos?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width / 1.77777 + 30
    }
    
}
