//
//  WatchListItem.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import RealmSwift
import Foundation

class WatchListItem: Object {
    @Persisted var movie: Movie?
    @Persisted var addedDate: Date?
}
