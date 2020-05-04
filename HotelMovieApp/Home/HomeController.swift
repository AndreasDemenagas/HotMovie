//
//  HomeController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserSignedIn()
    }
    
    fileprivate func checkIfUserSignedIn() {
        if FIRService.shared.getCurrentUserId() == nil {
            performLogOut()
        }
    }
    
    @objc func handleSignOut() {
        self.performLogOut()
    }
    
    fileprivate func performLogOut() {
        FIRService.shared.logoutUser { [weak self] (error)  in
            if let error = error {
                print("logout error", error)
                return
            }
            
            let loginController = LoginController()
            loginController.isModalInPresentation = true
            self?.present(loginController, animated: true)
        }
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    
}
