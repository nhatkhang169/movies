//
//  Movie.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import Foundation
import RealmSwift

@objc enum Genre: Int, PersistableEnum {
    case action
    case adventure
    case animation
    case comedy
    case crime
    case drama
    case scifi
    
    var title: String {
        switch self {
        case .action:
            return L10n.Genre.action
        case .adventure:
            return L10n.Genre.adventure
        case .animation:
            return L10n.Genre.animation
        case .comedy:
            return L10n.Genre.comedy
        case .crime:
            return L10n.Genre.crime
        case .drama:
            return L10n.Genre.drama
        case .scifi:
            return L10n.Genre.sf
        }
    }
}

class Movie: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var rating: Float
    @Persisted var duration: Int
    @Persisted var genres: List<Genre>
    @Persisted var releasedDate: Date
    @Persisted var trailer: String
    @Persisted var poster: String
}
