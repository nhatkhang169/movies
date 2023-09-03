//
//  Date+Extensions.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import Foundation

extension Date {
    var year: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    func toString(withFormat format: String = "yyyy, d MMMM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
