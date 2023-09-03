//
//  MoviesViewModelTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import RealmSwift
@testable import movies

class MoviesViewModelTests: BaseTestCase {
    lazy var genres: List<Genre> = {
        let list = List<Genre>()
        [.action, .animation].forEach { list.append($0) }
        return list
    }()
    
    lazy var movie1 = Movie(value: ["title": "test title",
                                    "desc": "test desc",
                                    "rating": 5.5,
                                    "duration": 100,
                                    "genres": genres,
                                    "releasedDate": "1 May 2015".toDate(),
                                    "trailer": "test trailer",
                                    "poster": "Tenet"
                                   ] as [String: Any])
    
    func testNumberOfRows() {
        // given
        let repo = MockMovieRepo()
        let sut = MoviesViewModel(repo: repo)
        repo.mockMovies = [WatchListMovie(movie: movie1, hasAddedToWatchList: false)]
        XCTAssertEqual(sut.numberOfRows, 0)
        
        // when
        sut.fetch()
        
        // then
        XCTAssertEqual(sut.numberOfRows, 1)
    }
    
    func testMovieAt() {
        // given
        let repo = MockMovieRepo()
        let sut = MoviesViewModel(repo: repo)
        repo.mockMovies = [WatchListMovie(movie: movie1, hasAddedToWatchList: false)]
        let movie1 = sut.movie(at: 0)
        XCTAssertNil(movie1)
        
        // when
        sut.fetch()
        let movie2 = sut.movie(at: 0)
        
        // then
        XCTAssertEqual(movie2?.movie.title, "test title")
    }
    
    func testFetch() {
        // given
        let repo = MockMovieRepo()
        let sut = MoviesViewModel(repo: repo)
        
        // when
        sut.fetch()
        
        // then
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.none)
    }
    
    func testOnUpdated() {
        // given
        let repo = MockMovieRepo()
        let sut = MoviesViewModel(repo: repo)
        let expectation = expectation(description: "test completed")
        
        // when
        sut.onUpdated.sink { _ in
            expectation.fulfill()
        }.store(in: &disposeBag)
        
        repo.mockUpdatedSubject.send()
        
        // then
        waitForExpectations(timeout: 1)
    }
    
    func testInitShouldTriggerObserving() {
        // given
        let repo = MockMovieRepo()
        XCTAssertNil(repo.didCallStartObserving)
        _ = MoviesViewModel(repo: repo)
        
        // then
        XCTAssertEqual(repo.didCallStartObserving, true)
    }
    
    func testSortedBy() {
        let repo = MockMovieRepo()
        XCTAssertNil(repo.didCallStartObserving)
        let sut = MoviesViewModel(repo: repo)
        XCTAssertEqual(sut.sortedBy, .none)
        
        // when, then
        sut.sortedBy = .title
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.title)
        
        // when, then
        sut.sortedBy = .title
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.desc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.title)
        
        // when, then
        sut.sortedBy = .title
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.title)
        
        // when, then
        sut.sortedBy = .releasedDate
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.releasedDate)
        
        // when, then
        sut.sortedBy = .releasedDate
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.desc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.releasedDate)
        
        // when, then
        sut.sortedBy = .title
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.title)
        
        // when, then
        sut.sortedBy = .releasedDate
        XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
        XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.releasedDate)
    }
}
