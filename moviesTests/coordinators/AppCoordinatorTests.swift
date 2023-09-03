//
//  AppCoordinatorTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class AppCoordinatorTests: BaseTestCase {
    func testGotoDetailShouldPushToDetailController() {
        // given
        let sut = AppCoordinator()
        let navController = MockUINavigationController()
        sut.navigationController = navController
        let movie = Movie()
        movie.title = "my movie title"
        let watchListMovie = WatchListMovie(movie: movie, hasAddedToWatchList: false)
        
        // when
        sut.gotoDetail(of: watchListMovie)
        
        // then
        let didCallPush = navController.didCallPushViewController
        let pushedController = didCallPush?.viewController as? MovieDetailViewController
        let viewingMovieTitle = pushedController?.viewModel?.title
        XCTAssertEqual(viewingMovieTitle, movie.title)
        XCTAssertEqual(didCallPush?.animated, true)
    }
    
    func testGotoDetailShouldCreateAChildCoordinator() {
        // given
        let sut = AppCoordinator()
        let navController = MockUINavigationController()
        sut.navigationController = navController
        let watchListMovie = WatchListMovie(movie: .init(), hasAddedToWatchList: false)
        
        // when
        sut.gotoDetail(of: watchListMovie)
        
        // then
        let didCallPush = navController.didCallPushViewController
        let pushedController = didCallPush?.viewController as? MovieDetailViewController
        XCTAssertTrue(pushedController?.coordinator is MoviesCoordinator)
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertTrue(sut.children.first  is MoviesCoordinator)
    }
    
    func testGotoDetailThenGoBackShouldClearChildCoordinator() {
        // given
        let sut = AppCoordinator()
        let navController = MockUINavigationController()
        sut.navigationController = navController
        let watchListMovie = WatchListMovie(movie: .init(), hasAddedToWatchList: false)
        sut.gotoDetail(of: watchListMovie)
        let didCallPush = navController.didCallPushViewController
        let pushedController = didCallPush?.viewController as? MovieDetailViewController
        let coordinator = pushedController?.coordinator as? MoviesCoordinator
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertTrue(sut.children.first  is MoviesCoordinator)
        
        // when
        coordinator?.finish()
        
        // then
        XCTAssertTrue(sut.children.isEmpty)
    }
}
