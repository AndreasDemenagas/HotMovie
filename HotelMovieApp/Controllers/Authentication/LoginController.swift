//
//  LoginController.swift
//  HotelMovieApp
//
//  Created by Andreas Demenagas on 9/4/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let movieDarkLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 45)
        l.text = "MovieRental"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.textColor = .white
        return l
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .bezel
        tf.layer.borderWidth = 1
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.tintColor = .white
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .bezel
        tf.layer.borderWidth = 1
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.cornerRadius = 10
        tf.layer.masksToBounds = true
        tf.tintColor = .white
        tf.isSecureTextEntry = true 
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = UIColor.lightGray.cgColor
        return tf
    }()
    
    let signInButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Log in", for: .normal)
        b.titleLabel?.textAlignment = .center
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        b.layer.cornerRadius = 20
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.masksToBounds = true
        return b
    }()
    
    let notAccountLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.text = "Don't have an account?"
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    lazy var signUpLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.text = "SIGN UP"
        l.textAlignment = .center
        l.isUserInteractionEnabled = true
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePresentSignUp)))
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()
    
    let inputContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientBackground()
        setupContainerView()
        setupInputs()
        setupLabels()
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        if Validator.shared.isValidEmail(input: email) {
            if Validator.shared.isValidPassword(input: password) {
                FirebaseService.shared.loginUser(email: email, password: password) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            else {
                print("bad password")
            }
        }
        else {
            print("bad email")
        }
        
    }
    
    @objc func handlePresentSignUp() {
        let signUpController = SignUpController()
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
       let stackView = UIStackView(arrangedSubviews: [notAccountLabel, signUpLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.anchor(top: inputContainerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 60))
    }
    
    fileprivate func setupContainerView() {
        view.addSubview(inputContainerView)
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
    }
    
    fileprivate func setupInputs() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        
        let itemSpacing: CGFloat = 24
        let topBottomPadding: CGFloat = 24
        let totalPadding: CGFloat = itemSpacing + itemSpacing + topBottomPadding + topBottomPadding
        let containerViewHeight = view.frame.height * 1/3
        let totalSpace = containerViewHeight - totalPadding
        let heightPerItem = totalSpace / 3
        
        emailTextField.anchor(top: inputContainerView.topAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: topBottomPadding, left: 24, bottom: 0, right: 24), size: .init(width: .zero, height: heightPerItem))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: itemSpacing, left: 24, bottom: 0, right: 24), size: .init(width: .zero, height: heightPerItem))
        
       signInButton.anchor(top: passwordTextField.bottomAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: itemSpacing, left: 48, bottom: 0, right: 48), size: .init(width: .zero, height: heightPerItem))
        
        view.addSubview(movieDarkLabel)
        movieDarkLabel.anchor(top: nil, leading: emailTextField.leadingAnchor, bottom: inputContainerView.topAnchor, trailing: inputContainerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 40))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

