//
//  MovieCast.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/6/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
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

