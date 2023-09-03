//
//  MockMovieDetailViewModel.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import Combine
import UIKit

class MockMovieDetailViewModel {
    var mockDesc = ""
    var mockPoster: UIImage?
    var mockRating = ""
    var mockTitle = ""
    var mockWatchListButtonText = "add-to-watch-list"
    var mockGenres = ""
    var mockReleasedDateText = ""
    var mockTrailer = ""
    var mockMovieUpdatedSubject = PassthroughSubject<Void, Never>()
    
    private(set) var didCallToggle = false
}

// MARK: - MovieDetailViewModelProtocol
extension MockMovieDetailViewModel: MovieDetailViewModelProtocol {
    var desc: String {
        mockDesc
    }
    
    var poster: UIImage? {
        mockPoster
    }
    
    var rating: String {
        mockRating
    }
    
    var title: String {
        mockTitle
    }
    
    var watchListButtonText: String {
        mockWatchListButtonText
    }
    
    var genres: String {
        mockGenres
    }
    
    var releasedDateText: String {
        mockReleasedDateText
    }
    
    var trailer: String {
         mockTrailer
    }
    
    var onMovieUpdated: AnyPublisher<Void, Never> {
        mockMovieUpdatedSubject.eraseToAnyPublisher()
    }
    
    func toggleInWatchList() {
        didCallToggle = true
    }
}
