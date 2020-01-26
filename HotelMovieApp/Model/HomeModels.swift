//
//  HomeModels.swift
//  HotelMovie App
//
//  IB DP Computer Science IA
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
