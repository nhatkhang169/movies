//
//  MockMovieRepo.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import RealmSwift
@testable import movies
import Combine

class MockMovieRepo {
    let mockUpdatedSubject = PassthroughSubject<Void, Never>()
    var mockMovies: [WatchListMovie] = []
    
    private(set) var didCallWatchListMovies: (sortedBy: SortType, sortOrder: SortOrder)?
    private(set) var didCallStartObserving: Bool?
    private(set) var didCallToggleInWatchList: String?
}

// MARK: MovieRepoProtocol
extension MockMovieRepo: MovieRepoProtocol {
    var onUpdated: AnyPublisher<Void, Never> {
        mockUpdatedSubject.eraseToAnyPublisher()
    }
    
    func watchListMovies(sortedBy: SortType, sortOrder: SortOrder) -> [WatchListMovie] {
        didCallWatchListMovies = (sortedBy, sortOrder)
        return mockMovies
    }
    
    func startObservingChanges() {
        didCallStartObserving = true
    }
    
    func toggleInWatchList(id: String) {
        didCallToggleInWatchList = id
    }
}
