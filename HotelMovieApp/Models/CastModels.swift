//
//  CastModels.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 11/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

struct CreditsResponse: Decodable {
    var id: Int?
    var cast: [CastMember]?
}

struct CastMember: Decodable {
    var cast_id: Int?
    var character: String?
    var credit_id: String?
    var gender: Int?
    var id: Int?
    var name: String?
    var order: Int?
    var profile_path: String?
}
