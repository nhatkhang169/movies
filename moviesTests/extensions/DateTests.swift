//
//  DateTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class DateTests: BaseTestCase {
    func testYear() {
        // given
        let sut = Date(timeIntervalSince1970: 0)
        
        // when
        let year = sut.year
        
        // then
        XCTAssertEqual(year, 1970)
    }
    
    func testToString() {
        // given
        let sut = Date(timeIntervalSince1970: 0)
        
        // when
        let dateString = sut.toString()
        
        // then
        XCTAssertTrue(dateString == "1970, 1 January" ||
                      dateString == "1970, 1 tháng 1")
    }
}
