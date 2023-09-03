//
//  Collection+Extensions.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import Foundation

extension Collection {
    public subscript(safe index: Self.Index) -> Self.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
