//
//  FirebaseService.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation
import Firebase

class FIRService {
    
    static let shared = FIRService()
    
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func loginUser(with email: String, and password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func logoutUser(completion: @escaping (Error?) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        }
        
        catch let error {
            completion(error)
        }
    }

}
