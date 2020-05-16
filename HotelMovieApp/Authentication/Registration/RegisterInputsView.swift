//
//  RegisterInputsView.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class RegisterInputsView: UIView {
    
    let containerView = UIView()
    
    let emailTextField: UITextField = {
        let tf = InputTextField(placeholder: "Email", cornerRadius: 15)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = InputTextField(placeholder: "Username", cornerRadius: 15)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = InputTextField(placeholder: "Password", isPassword: true, cornerRadius: 15)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton(title: "SIGN UP", backgroundColor: .clear, font: .boldSystemFont(ofSize: 18))
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        return btn
    }()
    
    var delegate: RegisterDelegate?
    
    @objc func handleRegisterUser() {
        guard let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else { return }
        delegate?.didTapRegister(with: username, email: email, and: password)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.fillSuperView()
        
        containerView.addSubview(usernameTextField)
        usernameTextField.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: 24), size: .init(width: .zero, height: 60))
        
        containerView.addSubview(emailTextField)
        emailTextField.anchor(top: usernameTextField.bottomAnchor, leading: usernameTextField.leadingAnchor, bottom: nil, trailing: usernameTextField.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 60))
        
        containerView.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: usernameTextField.leadingAnchor, bottom: nil, trailing: usernameTextField.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0), size: .init(width: .zero, height: 60))
        
        containerView.addSubview(signUpButton)
        signUpButton.anchor(top: passwordTextField.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 24, left: 48, bottom: 0, right: 48), size: .init(width: .zero, height: 60))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
