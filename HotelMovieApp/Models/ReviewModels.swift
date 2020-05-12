//
//  ReviewModels.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 12/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
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
