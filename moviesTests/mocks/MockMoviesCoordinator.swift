//
//  MockMoviesCoordinator.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import Combine
import UIKit

class MockMoviesCoordinator {
    let mockFinishedSubject = PassthroughSubject<Void, Never>()
    
    private(set) var didCallFinsh: Bool?
    private(set) var didCallWatchLaterAt: String?
}


// MARK: - MoviesCoordinatorProtocol
extension MockMoviesCoordinator: MoviesCoordinatorProtocol {
    var onFinished: AnyPublisher<Void, Never> {
        mockFinishedSubject.eraseToAnyPublisher()
    }
    
    func finish() {
        didCallFinsh = true
    }
    
    func watchTrailer(at address: String?) {
        didCallWatchLaterAt = address
    }
}
