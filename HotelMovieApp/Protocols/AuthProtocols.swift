//
//  LoginDelegate.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol LoginDelegate: AnyObject {
    func didTapLogin(with email: String?, and password: String?)
}

protocol RegisterDelegate: AnyObject {
    func didTapRegister(with username: String?, email: String?, and password: String?)
}
