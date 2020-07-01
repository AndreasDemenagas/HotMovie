//
//  Validator.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 19/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

enum ValidationError: LocalizedError {
    case emptyField
    case invalidEmail
    case invalidPassword
    case invalidUsername
    
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return "You have entered an invalid username."
        case .invalidPassword:
            return "Make sure your password is at least 6 characters long."
        case .invalidEmail:
            return "You have entered an invalid email."
        case .emptyField:
            return "Make sure you complete all fields."
        }
    }
}


enum LoginError: Error {
    case userDoesNotExist
    case invalidCredentials
    
    var description: String? {
        switch self {
        case .userDoesNotExist:
            return "This user does not exist"
        case .invalidCredentials:
            return "Incorrect password. Please try again."
        }
    }
}

struct Validator {
    
    static func validateEmail(_ emailString: String?) throws -> String {
        
        guard let emailString = emailString else { throw ValidationError.emptyField }
        guard emailString != "" else { throw ValidationError.emptyField }
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        guard emailPredicate.evaluate(with: emailString) else {
            throw ValidationError.invalidEmail
        }
        
        return emailString
    }
    
    static func validatePassoword(_ passwordString: String?) throws -> String {
        
        guard let passwordStr = passwordString else { throw ValidationError.emptyField }
        guard passwordStr != "" else { throw ValidationError.emptyField }
        
        guard passwordStr.count >= 6 else { throw ValidationError.invalidPassword }
        
        return passwordStr
    }

    static func validateUsername(_ username: String?) throws -> String {
        
        guard let username = username else { throw ValidationError.emptyField }
        guard username != "" else { throw ValidationError.emptyField }
        
        guard username.count >= 4 else { throw ValidationError.invalidUsername }
        
        return username
    }
    
    
}
