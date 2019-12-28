//
//  Alerts.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 28/12/19.
//  Copyright © 2019 Andrew Demenagas. All rights reserved.
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
    
    func invalidPassword(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Invalid Password", message: "Please make sure your password is at least 6 characters long")
    }
    
}
