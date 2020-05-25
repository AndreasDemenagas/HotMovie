//
//  Alerts.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 19/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

struct Alerts {
    
    static let shared = Alerts()
    
    func showAlertFromError(error: Error, on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Oups. Something went wrong", message: error.localizedDescription)
    }
    
    func unexpectedError(on viewController: UIViewController) {
        basicAlert(on: viewController, title: "Unexpected error", message: "There has been an error. Please try again in a few minutes...")
    }
    
    private func basicAlert(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        viewController.present(alertController, animated: true, completion: nil)
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

