//
//  MoviesCoordinatorTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class MoviesCoordinatorTests: BaseTestCase {
    func testOnFinishedShouldOmitWhenFinished() {
        // given
        let sut = MoviesCoordinator()
        let expectation = expectation(description: "test completed")
        
        // when
        sut.onFinished
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &disposeBag)
        sut.finish()
        
        // then
        waitForExpectations(timeout: 1)
    }
    
    func testWatchTrailerShouldPresentController() {
        // given
        let sut = MoviesCoordinator()
        let navController = MockUINavigationController()
        sut.navigationController = navController
        
        // when
        sut.watchTrailer(at: "test")
        
        // then
        let didCallPresent = navController.didCallPresentViewController
        let urlString = (didCallPresent?.viewController as? TrailerViewController)?.videoString
        XCTAssertEqual(urlString, "test")
        XCTAssertEqual(didCallPresent?.animated, true)
        XCTAssertNil(didCallPresent?.completion)
    }
}
