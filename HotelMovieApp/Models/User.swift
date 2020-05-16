//
//  User.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 16/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

struct UserM {
    let uid: String
    let username: String
    let email: String
    
    init(uid: String, dict: [String: Any]) {
        self.uid = uid
        self.username = dict["username"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
    }
}
