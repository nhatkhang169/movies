//
//  IntTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class IntTests: BaseTestCase {
    func testToDurationLessThan1Hour() {
        // given
        let sut = 15
        
        // when
        let duration = sut.toDuration()
        
        // then
        XCTAssertEqual(duration, "15min")
    }
    
    func testToDurationEqual1Hour() {
        // given
        let sut = 60
        
        // when
        let duration = sut.toDuration()
        
        // then
        XCTAssertEqual(duration, "1h")
    }
    
    func testToDurationMoreThan1Hour() {
        // given
        let sut = 83
        
        // when
        let duration = sut.toDuration()
        
        // then
        XCTAssertEqual(duration, "1h 23min")
    }
}
