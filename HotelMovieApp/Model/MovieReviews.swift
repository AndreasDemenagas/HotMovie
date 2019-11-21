//
//  MovieReviews.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/10/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
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
