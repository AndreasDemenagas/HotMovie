//
//  UILabel+Date.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 6/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit 

extension UILabel {
    
    func formatAndShowDate(dateString: String?, formatString: String) {
        guard let string = dateString else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: string) {
            let stringFormatter = DateFormatter()
            stringFormatter.dateFormat = formatString
            self.text = "Release: \(stringFormatter.string(from: date))"
        }
        
    }
    
}
