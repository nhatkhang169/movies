//
//  CollectionTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
@testable import movies

class CollectionTests: BaseTestCase {
    func testSafeWithNegativeIndex() {
        // given
        let index = -100
        let sut = ["a", "b", "c"]
        
        // when
        let item = sut[safe: index]
        
        // then
        XCTAssertNil(item)
    }
    
    func testSafeWith0Index() {
        // given
        let index = 0
        let sut = ["a", "b", "c"]
        
        // when
        let item = sut[safe: index]
        
        // then
        XCTAssertEqual(item, "a")
    }
    
    func testSafeWithEmptyCollection() {
        // given
        let index = 0
        let sut = [String]()
        
        // when
        let item = sut[safe: index]
        
        // then
        XCTAssertNil(item)
    }
    
    func testSafeWithPositiveIndex() {
        // given
        let index = 1
        let sut = ["a", "b", "c"]
        
        // when
        let item = sut[safe: index]
        
        // then
        XCTAssertEqual(item, "b")
    }
    
    func testSafeWithOutOfBoundsIndex() {
        // given
        let index = 5
        let sut = ["a", "b", "c"]
        
        // when
        let item = sut[safe: index]
        
        // then
        XCTAssertNil(item)
    }
}
