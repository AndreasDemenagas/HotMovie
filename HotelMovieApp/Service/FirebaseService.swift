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
    
    func fetchCurrentUser(completion: @escaping (Result<UserM, Error>) -> ()) {
        guard let userId = getCurrentUserId() else {
            return
        }
        
        Database.database().reference().child("users").child(userId).observe(.value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = UserM(uid: userId, dict: userDictionary)
            
            completion(.success(user))
            
        }) { (error) in
            completion(.failure(error))
        }
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
    
    func registerUser(email: String, username: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                print("Register User Error, ", error)
                return
            }
            
            guard let userId = result?.user.uid else { return }
            
            let values = ["username": username, "email": email]
            
            self.registerUserToDatabase(userId: userId, values: values, completion: completion)
        }
    }
    
    fileprivate func registerUserToDatabase(userId: String, values: [String: Any], completion: @escaping (Error?) -> () ) {
        print("register to db....")
        let reference = Database.database().reference().child("users").child(userId)
        
        reference.updateChildValues(values) { (error, reference) in
            if let error = error {
                completion(error)
                print("register to database error, ", error)
                return
            }
            
            completion(nil)
        }
    }

}

//
//let values = ["username": username, "email": email, "profileImageUrl": urlString]
//
//self.registerUserToDatabase(userId: userId, values: values, completion: completion)
