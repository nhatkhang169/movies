//
//  TrailerViewControllerTests.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import WebKit
@testable import movies

class TrailerViewControllerTests: BaseTestCase {
    var sut: TrailerViewController!
    
    func testViewDidLoadWithNilTrailer() {
        // given
        sut = TrailerViewController(urlString: nil)
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertNil(webview?.url)
    }
    
    func testViewDidLoadWithInvalidTrailer() {
        // given
        sut = TrailerViewController(urlString: "not a URL")
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertNil(webview?.url)
    }
    
    func testViewDidLoadWithValidTrailer() {
        // given
        sut = TrailerViewController(urlString: "https://a.com/")
        
        // when
        sut.loadViewIfNeeded()
        
        // then
        XCTAssertEqual(webview?.url?.absoluteString, "https://a.com/")
    }
}

// MARK: - Private

private extension TrailerViewControllerTests {
    var webview: WKWebView? {
        sut.view.subviews.first { $0 is WKWebView } as? WKWebView
    }
}
