//
//  RealmTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import RealmSwift
@testable import movies

class RealmTests: BaseTestCase {
    func test0ShouldMigrate() {
        // given
        let realm = try? Realm()
        let movies = realm?.objects(Movie.self)
        try? realm?.write {
            if let movies {
                realm?.delete(movies)
            }
        }
        let moviesBeforeMigrated = realm?.objects(Movie.self)
        XCTAssertEqual(moviesBeforeMigrated?.isEmpty, true)
        
        // when
        Realm.migrateIfNeeded()
        let moviesAfterMigrated = realm?.objects(Movie.self)
        
        // then
        XCTAssertEqual(moviesAfterMigrated?.isEmpty, false)
    }
    
    func test1ShouldNotMigrate() {
        // given
        let realm = try? Realm()
        let countBefore = realm?.objects(Movie.self).count
        
        // when
        Realm.migrateIfNeeded()
        let countAfter = realm?.objects(Movie.self).count
        
        // then
        XCTAssertEqual(countBefore, 5)
        XCTAssertEqual(countAfter, 5)
    }
}
