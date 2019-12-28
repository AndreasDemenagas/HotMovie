//
//  SignUpController.swift
//  socialLoginSignupPage
//
//  Created by Andreas Demenagas on 5/2/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "photoPlusButton").withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImage)))
        iv.isUserInteractionEnabled = true 
        return iv
    }()
    
    let inputContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .bezel
        tf.layer.borderWidth = 1
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.cornerRadius = 20
        tf.tintColor = .white
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .bezel
        tf.layer.borderWidth = 1
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.tintColor = .white
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.cornerRadius = 20
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .bezel
        tf.layer.borderWidth = 1
        tf.tintColor = .white
        tf.textColor = .white
        tf.isSecureTextEntry = true 
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.cornerRadius = 20
        tf.layer.masksToBounds = true
        tf.layer.borderColor = UIColor.lightGray.cgColor
        return tf
    }()
    
    let stack: UIStackView = {
        let s = UIStackView()
        s.spacing = 20
        s.distribution = .fillEqually
        s.axis = .vertical
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let signInButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("SIGN UP", for: .normal)
        b.titleLabel?.textAlignment = .center
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        b.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
       b.addTarget(self, action: #selector(handleRegisterUser), for: .touchUpInside)
        b.layer.cornerRadius = 20
        b.setTitleColor(.white, for: .normal)
        b.layer.masksToBounds = true
        return b
    }()
    
    lazy var backToLogin: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.text = "Back to login"
        l.textAlignment = .center
        l.isUserInteractionEnabled = true
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackToLogin)))
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientBackground()
        setupContainerView()
        setupInputs()
    }
    
    @objc func handleSelectImage() {
        let pickerController = ProfileImagePickerController()
        pickerController.isModalInPresentation = true
        pickerController.signUpController = self
        pickerController.allowsEditing = true
        pickerController.modalPresentationStyle = .fullScreen
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc func handleRegisterUser() {
        // TODO: Alerts
        guard let name = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let image = profileImageView.image else {
            return
        }
        
        if name == "" {
            Alert.shared.emptyNameLabel(on: self)
            print("bad name")
            return
        }
        
        if Validator.shared.isValidEmail(input: email) {
            if Validator.shared.isValidPassword(input: password) {
                FirebaseService.shared.registerUser(username: name, email: email, password: password, profileImage: image) {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Alert.shared.invalidPassword(on: self)
            }
        } else {
            Alert.shared.invalidEmailAlert(on: self)
        }

    }
    
    @objc func handleBackToLogin() {
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
        view.addSubview(inputContainerView)
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/4).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64).isActive = true
    }
    
    fileprivate func setupInputs() {
        view.addSubview(profileImageView)
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 16).isActive = true
        
        [usernameTextField, emailTextField, passwordTextField].forEach({stack.addArrangedSubview($0)})
        view.addSubview(stack)
        stack.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40).isActive = true
        stack.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 32).isActive = true
        stack.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        view.addSubview(signInButton)
        signInButton.anchor(top: stack.bottomAnchor, leading: inputContainerView.leadingAnchor, bottom: nil, trailing: inputContainerView.trailingAnchor, padding: .init(top: 40, left: 48, bottom: 0, right: 48))
        signInButton.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 1/3, constant: -20).isActive = true
        
        view.addSubview(backToLogin)
        backToLogin.anchor(top: signInButton.bottomAnchor, leading: signInButton.leadingAnchor, bottom: nil, trailing: signInButton.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        backToLogin.heightAnchor.constraint(equalTo: signInButton.heightAnchor).isActive = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
}
