//
//  DetailsProtocols.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 9/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol DetailsHeaderDelegate: AnyObject {
    func didCancel()
}

protocol TrailersDelegate: AnyObject {
    func didTapShowTrailers()
}

protocol AddToListDelegate: AnyObject {
    func didTapAddToList()
}
