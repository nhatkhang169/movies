//
//  String+Extensions.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "d MMMM yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_EN")
        return dateFormatter.date(from: self) ?? Date()
    }
}
