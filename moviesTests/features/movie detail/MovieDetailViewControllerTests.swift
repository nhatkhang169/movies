//
//  MovieDetailViewControllerTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class MovieDetailViewControllerTests: BaseTestCase {
    var sut: MovieDetailViewController!
    
    func testViewDidLoad() {
        // given
        sut = MovieDetailViewController(viewModel: MockMovieDetailViewModel())
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertEqual(sut.navigationItem.largeTitleDisplayMode, .never)
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
    
    func testAddToWatchListTouchUpInside() {
        // given
        let viewModel = MockMovieDetailViewModel()
        sut = MovieDetailViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        // when
        toggleButton?.sendActions(for: .touchUpInside)
        
        // then
        XCTAssertTrue(viewModel.didCallToggle)
    }
    
    func testWatchTrailerTouchUpInside() {
        // given
        let viewModel = MockMovieDetailViewModel()
        viewModel.mockTrailer = "test trailer"
        sut = MovieDetailViewController(viewModel: viewModel)
        let coordinator = MockMoviesCoordinator()
        sut.coordinator = coordinator
        sut.loadViewIfNeeded()
        
        // when
        watchTrailerButton?.sendActions(for: .touchUpInside)
        
        // then
        XCTAssertEqual(coordinator.didCallWatchLaterAt, "test trailer")
    }
    
    func testOnMovieUpdateShouldUpdateToggleButtonText() {
        // given
        let viewModel = MockMovieDetailViewModel()
        sut = MovieDetailViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        XCTAssertEqual(toggleButton?.titleLabel?.text, "add-to-watch-list")
        let expectation = expectation(description: "test completed")
        
        // when
        viewModel.mockWatchListButtonText = "remove-from-watch-list"
        viewModel.onMovieUpdated
            .sink { _ in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                    expectation.fulfill()
                }
            }
            .store(in: &disposeBag)
        viewModel.mockMovieUpdatedSubject.send()
        
        // then
        waitForExpectations(timeout: 1) { [weak self] _ in
            XCTAssertEqual(self?.toggleButton?.titleLabel?.text, "remove-from-watch-list")
        }
    }
}

// MARK: - Private

private extension MovieDetailViewControllerTests {
    var toggleButton: UIButton? {
        sut.view.subviews.first?.viewWithTag(1900) as? UIButton
    }
    
    var watchTrailerButton: UIButton? {
        sut.view.subviews.first?.viewWithTag(1901) as? UIButton
    }
}
