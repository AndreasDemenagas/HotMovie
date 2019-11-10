//
//  UILabel+DateExtension.swift
//  MoviesDarkFriend
//
//  Created by Andreas Demenagas on 9/6/19.
//  Copyright © 2019 Andreas Demenagas. All rights reserved.
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
