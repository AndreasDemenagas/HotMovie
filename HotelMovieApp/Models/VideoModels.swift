//
//  VideoModels.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
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
