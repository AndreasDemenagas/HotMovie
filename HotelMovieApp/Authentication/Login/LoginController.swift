//
//  LoginController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class LoginController: UIViewController, LoginDelegate {
    
    let movieDarkLabel: UILabel = {
        let l = UILabel(text: "MovieRental", font: .boldSystemFont(ofSize: 45))
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    lazy var inputsView: LoginInputView = {
        let v = LoginInputView()
        v.delegate = self
        return v
    }()
    
    let notAccountLabel = UILabel(text: "Don't have an account?", textColor: .lightGray, font: .systemFont(ofSize: 18), alignment: .center)
    
    lazy var signUpLabel: UILabel = {
        let l = UILabel(text: "SIGN UP", font: .systemFont(ofSize: 18), alignment: .center)
        l.isUserInteractionEnabled = true
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePresentSignUp)))
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientBackground()
        setupContainerView()
        setupInputs()
        setupLabels()
        
        setupKeyboardObserversAndTap()
    }
    
    fileprivate func setupKeyboardObserversAndTap() {
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleShowKeyboard() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = .init(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    @objc private func handleHideKeyboard() {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func didTapLogin(with email: String, and password: String) {
        print(email, password)
    }
    
    @objc func handlePresentSignUp() {
        let signUpController = RegistrationController()
        present(signUpController, animated: true, completion: nil)
    }
    
    fileprivate func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor, #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0.0, 0.8, 1.0]
        view.layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupLabels() {
        view.addSubview(movieDarkLabel)
        movieDarkLabel.anchor(top: nil, leading: inputsView.leadingAnchor, bottom: inputsView.topAnchor, trailing: inputsView.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 0), size: .init(width: .zero, height: 40))

        let stack = UIStackView(arrangedSubviews: [notAccountLabel, self.signUpLabel])
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .fillEqually

        view.addSubview(stack)

        stack.anchor(top: inputsView.bottomAnchor, leading: inputsView.leadingAnchor, bottom: nil, trailing: inputsView.trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 70))
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func setupContainerView() {
        view.addSubview(inputsView)
        inputsView.translatesAutoresizingMaskIntoConstraints = false

        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 180 + 24 + 24).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
    }
    
    fileprivate func setupInputs() {
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}



