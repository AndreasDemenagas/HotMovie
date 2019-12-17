//
//  HomeModels.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/7/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import Foundation

struct UpcomingMovies: Decodable {
    let results: [Movie]?
}

struct PopularMovies: Decodable {
    let results: [Movie]?
}

struct NowPlayingMovies: Decodable {
    let results: [Movie]?
}

struct TopRatedMovies: Decodable {
    let results: [Movie]?
}
