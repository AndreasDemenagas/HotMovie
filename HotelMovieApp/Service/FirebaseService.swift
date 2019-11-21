//
//  FirebaseService.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/21/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    static let shared = FirebaseService()
    
    func fetchUserList(completion: @escaping ([Movie]) -> () ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let reference = Database.database().reference().child("lists").child(userId)
        
        var movies = [Movie]()
        
        let group = DispatchGroup()
        
        reference.observe(.childAdded, with: { (snapshot) in
            guard let movieId = snapshot.value as? Int else { return }
            
            group.enter()
            
            ApiService.shared.fetchMovieDetails(id: movieId) { (result) in
                switch result {
                case .failure(let error):
                    print("failed to fetched details...", error)
                case .success(let movie):
                    movies.append(movie)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                print("completion...")
                completion(movies)
            }
    
        }, withCancel: nil)
        
//        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
//            print("After 3... \(movies.count)")
//            completion(movies)
//        }
        
    }
    
    func addMovieToList(movieId: Int, completion: @escaping () -> () ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let values = [UUID().uuidString: movieId]
        
        let reference = Database.database().reference().child("lists").child(userId)
        
        reference.updateChildValues(values) { (error, reference) in
            if let error = error {
                print("adding to list error, ", error)
                return
            }
            
            print("movie: \(movieId) added to list....")
            
            completion() 
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping () -> () ) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("log in error, ", error)
                return
            }
            
            print("logged in...")
            completion()
        }
    }
    
    func registerUser(username: String, email: String, password: String, profileImage: UIImage, completion: @escaping () -> () ) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("register error, ", error)
                return
            }
            
            guard let userId = result?.user.uid else { return }
            let imageStorageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile-images").child("\(imageStorageName).png")
        
            guard let imageData = profileImage.jpegData(compressionQuality: 0.1) else { return }
            
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("upload image error, ", error)
                    return
                }
                print("image uploaded good....")
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("url down error, ", error)
                        return
                    }
                    
                    guard let urlString = url?.absoluteString else { return }
                    
                    let values = ["username": username, "email": email, "profileImageUrl": urlString]
                    
                    self.registerUserToDatabase(userId: userId, values: values, completion: completion)
                }
            }
        }
        
    }
    
    func registerUserToDatabase(userId: String, values: [String: Any], completion: @escaping () -> () ) {
        print("register to db....")
        let reference = Database.database().reference().child("users").child(userId)
        
        reference.updateChildValues(values) { (error, reference) in
            if let error = error {
                print("register to database error, ", error)
                return
            }
            
            completion()
        }
    }
    
}
