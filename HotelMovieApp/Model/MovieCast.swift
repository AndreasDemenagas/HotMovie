//
//  MovieCast.swift
//  MoviesDarkFriend
//
//  IB DP Computer Science IA
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

