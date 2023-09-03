//
//  StringTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class StringTests: BaseTestCase {
    func testToDate() {
        // given
        let date1 = "3 September 2020"
        let date2 = "14 December 2018"
        let date3 = "27 November 2019"
        let date4 = "1 August 2014"
        let date5 = "1 May 2015"
        
        let date6 = "41 May 2015"
        let date7 = "1 Sept 2015"
        let date8 = "1 May 05"
        
        // then
        XCTAssertEqual(date1.toDate().year, 2020)
        XCTAssertEqual(date2.toDate().year, 2018)
        XCTAssertEqual(date3.toDate().year, 2019)
        XCTAssertEqual(date4.toDate().year, 2014)
        XCTAssertEqual(date5.toDate().year, 2015)
        XCTAssertEqual(date6.toDate().year, Date().year)
        XCTAssertEqual(date7.toDate().year, Date().year)
        XCTAssertEqual(date8.toDate().year, 5)
    }
}
