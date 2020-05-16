//
//  UIKit+Extensions.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 3/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//


import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor = .white, font: UIFont? = nil, alignment: NSTextAlignment = .left, numberOfLines: Int = 0) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}

extension UIButton {
    convenience init(title: String, titleAlignment: NSTextAlignment = .center, backgroundColor: UIColor = .black, titleColor: UIColor = .white, cornerRadius: CGFloat = 20, font: UIFont? = nil) {
        
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.titleLabel?.textAlignment = titleAlignment
        self.backgroundColor = backgroundColor
        self.setTitleColor(titleColor, for: .normal)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
}


