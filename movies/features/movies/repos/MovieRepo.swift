//
//  MovieRepo.swift
//  movies
//
//  Created by azun on 31/08/2023.
//

import RealmSwift
import Foundation
import Combine

protocol MovieRepoProtocol {
    var onUpdated: AnyPublisher<Void, Never> { get }
    
    func watchListMovies(sortedBy: SortType, sortOrder: SortOrder) -> [WatchListMovie]
    func startObservingChanges()
    func toggleInWatchList(id: String)
}

class MovieRepo {
    let realm = try? Realm()
    private let updatedSubject = PassthroughSubject<Void, Never>()
    var notificationToken: NotificationToken?
}

// MARK: - MovieRepoProtocol

extension MovieRepo: MovieRepoProtocol {
    func watchListMovies(sortedBy: SortType, sortOrder: SortOrder) -> [WatchListMovie] {
        guard let movies = realm?.objects(Movie.self),
              let watchListItems = realm?.objects(WatchListItem.self) else { return [] }
        
        let result: [WatchListMovie] = movies.map { movie in
            WatchListMovie(movie: movie,
                           hasAddedToWatchList: watchListItems.contains(where: { item in
                item.movie == movie
            }))
        }
        
        switch sortedBy {
        case .none:
            return result
        case .title:
            return result.sorted {
                if sortOrder == .asc {
                    return $0.movie.title < $1.movie.title
                }
                return $0.movie.title > $1.movie.title
            }
        case .releasedDate:
            return result.sorted {
                if sortOrder == .asc {
                    return $0.movie.releasedDate < $1.movie.releasedDate
                }
                return $0.movie.releasedDate > $1.movie.releasedDate
            }
        }
    }
    
    func startObservingChanges() {
        guard let watchListItems = realm?.objects(WatchListItem.self) else { return }
        notificationToken = watchListItems.observe { [weak self] (changes: RealmCollectionChange) in
            self?.updatedSubject.send()
        }
    }
    
    func toggleInWatchList(id: String) {
        guard let movie = realm?.objects(Movie.self).first(where: { $0.id == id }) else { return }
        let watchListItems = realm?.objects(WatchListItem.self).first(where: { $0.movie?.id == id })
        try? realm?.write {
            if let item = watchListItems {
                realm?.delete(item)
            }
            else {
                let newItem = WatchListItem()
                newItem.movie = movie
                newItem.addedDate = Date()
                realm?.add(newItem)
            }
        }
    }
    
    var onUpdated: AnyPublisher<Void, Never> {
        updatedSubject.eraseToAnyPublisher()
    }
}
