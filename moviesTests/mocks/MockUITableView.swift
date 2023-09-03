//
//  MockUITableView.swift
//  moviesTests
//
//  Created by azun on 02/09/2023.
//

@testable import movies
import UIKit

class MockUITableView: UITableView {
    var mockDequeueReusableCell: UITableViewCell?
    
    private(set) var didCallDequeueReusableCell: String?
    
    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        didCallDequeueReusableCell = identifier
        return mockDequeueReusableCell
    }
}
