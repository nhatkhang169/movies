//
//  MovieDetailViewModelTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import RealmSwift
@testable import movies

class MovieDetailViewModelTests: BaseTestCase {
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
    
    let movie2 = Movie(value: ["title": "test title",
                               "desc": "test desc",
                               "rating": 5.5,
                               "duration": 100,
                               "genres": List<Genre>(),
                               "releasedDate": "11 May 2015".toDate(),
                               "trailer": "test trailer",
                               "poster": "test poster"
                              ] as [String: Any])
    
    func testPropertiesOfMovie1() {
        // given
        let sut = MovieDetailViewModel(movie: WatchListMovie(movie: movie1, hasAddedToWatchList: false))
        
        // then
        XCTAssertEqual(sut.desc, movie1.desc)
        XCTAssertEqual(sut.genres, "\(L10n.Genre.action), \(L10n.Genre.animation)")
        XCTAssertNotNil(sut.poster)
        XCTAssertEqual(sut.rating, "5.5")
        XCTAssertEqual(sut.releasedDateText, movie1.releasedDate.toString())
        XCTAssertEqual(sut.title, movie1.title)
        XCTAssertEqual(sut.trailer, movie1.trailer)
        XCTAssertEqual(sut.watchListButtonText, L10n.MovieDetail.Button.addToWatchList)
    }
    
    func testPropertiesOfMovie2() {
        // given
        let sut = MovieDetailViewModel(movie: WatchListMovie(movie: movie2, hasAddedToWatchList: true))
        
        // then
        XCTAssertEqual(sut.desc, movie2.desc)
        XCTAssertTrue(sut.genres.isEmpty)
        XCTAssertNil(sut.poster)
        XCTAssertEqual(sut.rating, "5.5")
        XCTAssertEqual(sut.releasedDateText, movie2.releasedDate.toString())
        XCTAssertEqual(sut.title, movie2.title)
        XCTAssertEqual(sut.trailer, movie2.trailer)
        XCTAssertEqual(sut.watchListButtonText, L10n.MovieDetail.Button.removeFromWatchList)
    }
    
    func testOnMovieUpdateWhenTogglingToAdd() {
        // given
        let movie = WatchListMovie(movie: movie2, hasAddedToWatchList: false)
        let repo = MockMovieRepo()
        repo.mockMovies = [WatchListMovie(movie: movie2, hasAddedToWatchList: true)]
        let sut = MovieDetailViewModel(movie: movie, repo: repo)
        XCTAssertFalse(sut.movie.hasAddedToWatchList)
        
        let expectation = expectation(description: "test completed")
        sut.onMovieUpdated
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &disposeBag)
        
        // when
        sut.toggleInWatchList()
        repo.mockUpdatedSubject.send()
        
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(sut.movie.hasAddedToWatchList)
            XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.none)
            XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
            XCTAssertEqual(repo.didCallToggleInWatchList, self.movie2.id)
        }
    }
    
    func testOnMovieUpdateWhenTogglingToRemove() {
        // given
        let movie = WatchListMovie(movie: movie2, hasAddedToWatchList: true)
        let repo = MockMovieRepo()
        repo.mockMovies = [WatchListMovie(movie: movie2, hasAddedToWatchList: false)]
        let sut = MovieDetailViewModel(movie: movie, repo: repo)
        XCTAssertTrue(sut.movie.hasAddedToWatchList)
        
        let expectation = expectation(description: "test completed")
        sut.onMovieUpdated
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &disposeBag)
        
        // when
        sut.toggleInWatchList()
        repo.mockUpdatedSubject.send()
        
        // then
        waitForExpectations(timeout: 1) { _ in
            XCTAssertFalse(sut.movie.hasAddedToWatchList)
            XCTAssertEqual(repo.didCallWatchListMovies?.sortedBy, SortType.none)
            XCTAssertEqual(repo.didCallWatchListMovies?.sortOrder, SortOrder.asc)
            XCTAssertEqual(repo.didCallToggleInWatchList, self.movie2.id)
        }
    }
}
