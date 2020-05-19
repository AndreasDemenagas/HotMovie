//
//  Alerts.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 19/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class Alert {
    
    static let shared = Alert()
    
    private func basicAlert(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    func invalidEmailAlert(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Invalid email", message: "Please enter a valid email...")
    }
    
    func emptyNameLabel(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Empty Name", message: "Please enter a username")
    }
    
    func emptyPasswordField(on vc: UIViewController) {
        basicAlert(on: vc, title: "Empty Password", message: "Make sure your password is at least 6 characters long")
    }
    
    func invalidPassword(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Invalid Password", message: "Please make sure your password is at least 6 characters long")
    }
    
    func loginError(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Login Error", message: "The password you have entered is not correct")
    }
    
    func unexpectedError(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Unexpected error", message: "There has been an error. Please try again in a few minutes...")
    }
    
    func signOutConfirm(on viewController: UIViewController, completion: @escaping (UIAlertAction) -> () ) {
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: completion)
        let confirmAction = UIAlertAction(title: "Log out", style: .default, handler: completion)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
