//
//  MovieCellViewModelTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import RealmSwift
@testable import movies

class MovieCellViewModelTests: BaseTestCase {
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
                               "releasedDate": "11 May 2020".toDate(),
                               "trailer": "test trailer",
                               "poster": "test poster"
                              ] as [String: Any])
    
    func testPropertiesOfMovie1() {
        // given
        let sut = MovieCellViewModel(movie: WatchListMovie(movie: movie1, hasAddedToWatchList: false))
        
        // then
        XCTAssertEqual(sut.durationAndGenres, "1h 40min - Action, Animation")
        XCTAssertFalse(sut.isOnMyWatchList)
        XCTAssertNotNil(sut.poster)
        XCTAssertEqual(sut.title, "test title (2015)")
    }
    
    func testPropertiesOfMovie2() {
        // given
        let sut = MovieCellViewModel(movie: WatchListMovie(movie: movie2, hasAddedToWatchList: true))
        
        // then
        XCTAssertEqual(sut.durationAndGenres, "1h 40min")
        XCTAssertTrue(sut.isOnMyWatchList)
        XCTAssertNil(sut.poster)
        XCTAssertEqual(sut.title, "test title (2020)")
    }
}
