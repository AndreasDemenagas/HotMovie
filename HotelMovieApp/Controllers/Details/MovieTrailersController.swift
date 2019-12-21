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
    
    var movie: Movie? {
        didSet {
            print(movie?.id ?? "NIL NOVIE" )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieTrailerCell.self, forCellReuseIdentifier: trailerCellid)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width / 1.777777 + 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: trailerCellid) as! MovieTrailerCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
