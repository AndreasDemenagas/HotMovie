//
//  HomeSectionModels.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 13/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
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
