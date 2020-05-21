//
//  LoginInputsView.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class LoginInputView: UIView {
    
    let inputContainerView = UIView()
    
    lazy var emailTextField: InputTextField = {
        let tf = InputTextField(placeholder: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = InputTextField(placeholder: "Password", isPassword: true)
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton(title: "Log in", backgroundColor: .clear, font: .boldSystemFont(ofSize: 18))
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return btn
    }()
    
    @objc func loginPressed() {
        let email = emailTextField.text
        let password = passwordTextField.text 
        delegate?.didTapLogin(with: email, and: password)
    }
    
    var delegate: LoginDelegate? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        addSubview(inputContainerView)
        inputContainerView.fillSuperView()
        
        addSubview(emailTextField)
        emailTextField.anchor(top: inputContainerView.topAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24), size: .init(width: .zero, height: 60))
        
        addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: emailTextField.leadingAnchor, bottom: nil, trailing: emailTextField.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 60))
        
        addSubview(signInButton)
        signInButton.anchor(top: passwordTextField.bottomAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: 24, left: 48, bottom: 0, right: 48), size: .init(width: .zero, height: 60))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
