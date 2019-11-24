//
//  Validator.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 24/11/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
//

import UIKit

class Validator {
    
    static let shared = Validator()
    
    func isValidEmail(input: String) -> Bool {
        if input.contains("@") {
            if input.contains(".") {
                return true
            }
            return false
        }
        
        return false
    }
    
    func isValidPassword(input: String) -> Bool {
        if input.count >= 6 {
            return true
        }
        
        return false
    }
    
}
