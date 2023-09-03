//
//  Int+Extensions.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import Foundation

extension Int {
    
    func toDuration() -> String {
        let hours = self / 60
        let minutes = self % 60
        var duration: [String] = []
        if hours > 0 {
            duration.append("\(hours)\(L10n.Duration.hour)")
        }
        
        if minutes > 0 {
            duration.append("\(minutes)\(L10n.Duration.minute)")
        }
        
        return duration.joined(separator: " ")
    }
}
