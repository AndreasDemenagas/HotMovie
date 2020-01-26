//
//  Validator.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
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
