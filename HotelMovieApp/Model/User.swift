//
//  User.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/22/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
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
