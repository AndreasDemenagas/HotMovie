//
//  CellProtocols.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol ItemCell {
    static var id: String { get }
    func setupCell()
}
