//
//  MovieReviews.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import Foundation

struct ReviewResponse: Decodable {
    var id: Int
    var page: Int
    var results: [Review]
}

struct Review: Decodable {
    var author: String
    var content: String
    var id: String
    var url: String
}
