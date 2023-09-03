//
//  MoviesViewControllerTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class MoviesViewControllerTests: BaseTestCase {
    var sut: MoviesViewController!
    
    func testViewDidLoad() {
        // given
        sut = MoviesViewController(viewModel: MockMoviesViewModel())
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertEqual(sut.title, L10n.Movies.title)
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, L10n.Movies.Button.sort)
        
        XCTAssertEqual(sut.navigationItem.largeTitleDisplayMode, .always)
    }
    
    func testNumberOfRowsInSection() {
        // given
        let viewModel = MockMoviesViewModel()
        viewModel.mockNumberOfRows = 100
        sut = MoviesViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        // when
        let numberOfRows = sut.tableView(UITableView(), numberOfRowsInSection: 0)
        
        // then
        XCTAssertEqual(numberOfRows, 100)
    }
    
    func testCellForRow() {
        // given
        let viewModel = MockMoviesViewModel()
        viewModel.mockNumberOfRows = 100
        viewModel.mockMovieAt = WatchListMovie(movie: Movie(), hasAddedToWatchList: false)
        sut = MoviesViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        let table = MockUITableView()
        table.mockDequeueReusableCell = MovieCell(style: .default, reuseIdentifier: MovieCell.cellId)
        
        // when
        
        let cell = sut.tableView(table, cellForRowAt: .init(row: 0, section: 0))
        
        // then
        XCTAssertTrue(cell is MovieCell)
        XCTAssertEqual(table.didCallDequeueReusableCell, MovieCell.cellId)
    }
    
    func testSelectRow() {
        // given
        let viewModel = MockMoviesViewModel()
        viewModel.mockMovieAt = WatchListMovie(movie: Movie(), hasAddedToWatchList: false)
        sut = MoviesViewController(viewModel: viewModel)
        let coordinator = MockAppCoordinator()
        sut.coordinator = coordinator
        XCTAssertNil(coordinator.didCallGotoDetail)
        sut.loadViewIfNeeded()
        let table = MockUITableView()
        
        // when
        sut.tableView(table, didSelectRowAt: .init(row: 0, section: 0))
        
        // then
        XCTAssertNotNil(coordinator.didCallGotoDetail)
    }
}
