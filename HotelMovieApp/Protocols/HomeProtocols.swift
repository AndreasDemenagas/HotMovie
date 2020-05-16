//
//  HomeProtocols.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 13/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import Foundation

protocol HomeFeedDelegate: AnyObject {
    func didTapHomeMovie(movie: Movie?)
}
