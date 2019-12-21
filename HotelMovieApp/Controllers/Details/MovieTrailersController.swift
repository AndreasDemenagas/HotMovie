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
    
    var movie: Movie? {
        didSet {
            print(movie?.id ?? "NIL NOVIE" )
            guard let id = movie?.id else { return }
            fetchVideos(movieId: id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        tableView.allowsSelection = false 
        tableView.register(MovieTrailerCell.self, forCellReuseIdentifier: trailerCellid)
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
        movieVideos = videos.filter({ (video) -> Bool in
            video.site == "YouTube" && (video.type == "Trailer" || video.type == "Teaser")
        })
        tableView.reloadData()
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
