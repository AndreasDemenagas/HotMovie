//
//  RegistrationController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit 

class RegistrationController: UIViewController, RegisterDelegate {
    
    let registerLabel: UILabel = {
        let l = UILabel(text: "Register", font: .boldSystemFont(ofSize: 45))
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    lazy var registerInputsView: RegisterInputsView = {
        let v = RegisterInputsView()
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var backToLogin: UILabel = {
        let l = UILabel(text: "Back to login", font: .systemFont(ofSize: 18), alignment: .center)
        l.isUserInteractionEnabled = true
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackToLogin)))
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientBackground()
        setupContainerView()
        setupInputs()
        setupKeyboardObserversAndTap()
    }
    
    func didTapRegister(with username: String, email: String, and password: String) {
        FIRService.shared.registerUser(email: email, username: username, password: password) { (error) in
            if let error = error {
                print("Register Error, ", error)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func setupKeyboardObserversAndTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleShowKeyboard() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = .init(x: 0, y: -150, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func handleHideKeyboard() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    @objc private func handleBackToLogin() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 0.6, 1.0]
        gradientLayer.startPoint = .init(x: 0, y: 0)
        gradientLayer.endPoint = .init(x: 0, y: 1)
        gradientLayer.frame = view.frame
        view.layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupContainerView() {
        view.addSubview(registerInputsView)
        registerInputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerInputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        
        let height: CGFloat = (4 * 60) + (3 * 24)
        
        registerInputsView.heightAnchor.constraint(equalToConstant: height).isActive = true
        registerInputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64).isActive = true
        
        view.addSubview(registerLabel)
        registerLabel.anchor(top: nil, leading: registerInputsView.leadingAnchor, bottom: registerInputsView.topAnchor, trailing: registerInputsView.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 0), size: .init(width: .zero, height: 40))
    }
    
    fileprivate func setupInputs() {
        view.addSubview(backToLogin)
        backToLogin.anchor(top: registerInputsView.bottomAnchor, leading: registerInputsView.leadingAnchor, bottom: nil, trailing: registerInputsView.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 30))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
