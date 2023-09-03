//
//  GenreTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import XCTest

class GenreTests: BaseTestCase {
    func testGenreTitle() {
        XCTAssertEqual(Genre.action.title, L10n.Genre.action)
        XCTAssertEqual(Genre.adventure.title, L10n.Genre.adventure)
        XCTAssertEqual(Genre.animation.title, L10n.Genre.animation)
        XCTAssertEqual(Genre.comedy.title, L10n.Genre.comedy)
        XCTAssertEqual(Genre.crime.title, L10n.Genre.crime)
        XCTAssertEqual(Genre.drama.title, L10n.Genre.drama)
        XCTAssertEqual(Genre.scifi.title, L10n.Genre.sf)
    }
}
