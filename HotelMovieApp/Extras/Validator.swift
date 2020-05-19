//
//  Validator.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 19/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case invalidEmail
    case invalidPassword
    case invalidUsername
}

struct Validator {
    
    static func isValidEmail(_ string: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }

    static func isValidPassword(_ string: String) -> Bool {
        return string.count >= 6 ? true : false
    }
    
    static func validUsername(_ string: String) -> Bool {
        return string.count >= 4 ? true : false
    }
    
    
}
