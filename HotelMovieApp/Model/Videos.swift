//
//  Videos.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import Foundation

struct MovieVideo: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}


struct VideoResponse: Decodable {
    let id: Int
    let results: [MovieVideo]?
}


