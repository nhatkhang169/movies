//
//  MovieRepoTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import RealmSwift
@testable import movies

class MovieRepoTests: BaseTestCase {
    
    func testWatchListMovies() {
        // given
        let sut = MovieRepo()
        
        // when
        let result1 = sut.watchListMovies(sortedBy: .none, sortOrder: .asc)
        let result2 = sut.watchListMovies(sortedBy: .title, sortOrder: .desc)
        let result3 = sut.watchListMovies(sortedBy: .title, sortOrder: .asc)
        let result4 = sut.watchListMovies(sortedBy: .releasedDate, sortOrder: .desc)
        let result5 = sut.watchListMovies(sortedBy: .releasedDate, sortOrder: .asc)
        
        // then
        XCTAssertEqual(result1.first?.movie.title, "Tenet")
        XCTAssertEqual(result1[safe: 1]?.movie.title, "Spider-Man: Into the Spider-Verse")
        
        XCTAssertEqual(result2.first?.movie.title, "Tenet")
        XCTAssertEqual(result2[safe: 1]?.movie.title, "Spider-Man: Into the Spider-Verse")
        
        XCTAssertEqual(result3.first?.movie.title, "Avengers: Age of Ultron")
        XCTAssertEqual(result3[safe: 1]?.movie.title, "Guardians of the Galaxy")
        
        XCTAssertEqual(result4.first?.movie.title, "Tenet")
        XCTAssertEqual(result4[safe: 1]?.movie.title, "Knives Out")
        
        XCTAssertEqual(result5.first?.movie.title, "Guardians of the Galaxy")
        XCTAssertEqual(result5[safe: 1]?.movie.title, "Avengers: Age of Ultron")
    }
    
    func testToggleInWatchList() {
        // given
        let sut = MovieRepo()
        let watchMovie = sut.watchListMovies(sortedBy: .none, sortOrder: .asc).first
        
        // when, then
        sut.toggleInWatchList(id: watchMovie?.movie.id ?? "")
        let watchMovie1 = sut.watchListMovies(sortedBy: .none, sortOrder: .asc).first {
            $0.movie.id == watchMovie?.movie.id
        }
        XCTAssertNotEqual(watchMovie?.hasAddedToWatchList, watchMovie1?.hasAddedToWatchList)
        
        // when, then
        sut.toggleInWatchList(id: watchMovie?.movie.id ?? "")
        let watchMovie2 = sut.watchListMovies(sortedBy: .none, sortOrder: .asc).first {
            $0.movie.id == watchMovie?.movie.id
        }
        XCTAssertNotEqual(watchMovie1?.hasAddedToWatchList, watchMovie2?.hasAddedToWatchList)
    }
}
