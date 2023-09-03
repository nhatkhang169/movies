//
//  MockAppCoordinator.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import Combine
import UIKit

class MockAppCoordinator {
    private(set) var didCallGotoDetail: WatchListMovie?
}


// MARK: - AppCoordinatorProtocol
extension MockAppCoordinator: AppCoordinatorProtocol {
    func gotoDetail(of movie: WatchListMovie) {
        didCallGotoDetail = movie
    }
}
