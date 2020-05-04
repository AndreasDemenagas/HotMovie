//
//  HomeController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("123")
        
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserSignedIn()
    }
    
    fileprivate func checkIfUserSignedIn() {
        if Auth.auth().currentUser?.uid == nil {
            performLogOut()
        }
    }
    
    @objc func handleSignOut() {
        self.performLogOut()
    }
    
    @objc fileprivate func performLogOut() {
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError {
            print("Log out error", logoutError)
        }
        
        let loginController = LoginController()
        loginController.isModalInPresentation = true
        present(loginController, animated: true)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    
}
