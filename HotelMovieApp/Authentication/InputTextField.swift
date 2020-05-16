//
//  InputTextField.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit

class InputTextField: UITextField, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(placeholder: String, isPassword: Bool = false, cornerRadius: CGFloat = 10) {
        super.init(frame: .zero)
        
        delegate = self
        borderStyle = .bezel
        layer.borderWidth = 1
        font = UIFont.systemFont(ofSize: 18)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        tintColor = .white
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        layer.borderColor = UIColor.lightGray.cgColor
        isSecureTextEntry = isPassword
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.superview?.endEditing(true)
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
