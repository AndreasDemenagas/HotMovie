//
//  Videos.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 21/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
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
    let id: String
    let results: [MovieVideo]?
}


