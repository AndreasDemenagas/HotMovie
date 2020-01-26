//
//  User.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

struct UserModel {
    var username: String
    var email: String
    var profileImageUrl: String
    
    init(with dictionary: [String: Any]) {
        username = dictionary["username"] as! String
        email = dictionary["email"] as! String
        profileImageUrl = dictionary["profileImageUrl"] as! String
    }
}

struct List {
    var userId: String
    var movieIds: [String]
}
