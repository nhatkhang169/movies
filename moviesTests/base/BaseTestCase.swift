//
//  BaseTestCase.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

import XCTest
import Combine

class BaseTestCase: XCTestCase {
    var disposeBag = Set<AnyCancellable>()
}
