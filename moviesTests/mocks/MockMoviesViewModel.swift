//
//  MockMoviesViewModel.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import Combine
import UIKit

class MockMoviesViewModel {
    var mockNumberOfRows = 0
    var mockSortedBy: SortType = .none
    var mockMovieAt: WatchListMovie?
    
    var mockUpdatedSubject = PassthroughSubject<Void, Never>()
    
    private(set) var didCallFetch: Bool?
    private(set) var didSetSortedBy: SortType?
    private(set) var didCallMovieAt: Int?
}

// MARK: - MoviesViewModelProtocol
extension MockMoviesViewModel: MoviesViewModelProtocol {
    var numberOfRows: Int {
        mockNumberOfRows
    }
    
    var onUpdated: AnyPublisher<Void, Never> {
        mockUpdatedSubject.eraseToAnyPublisher()
    }
    
    var sortedBy: SortType {
        get {
            mockSortedBy
        }
        set(newValue) {
            didSetSortedBy = newValue
        }
    }
    
    func fetch() {
        didCallFetch = true
    }
    
    func movie(at index: Int) -> WatchListMovie? {
        didCallMovieAt = index
        return mockMovieAt
    }
    
}
