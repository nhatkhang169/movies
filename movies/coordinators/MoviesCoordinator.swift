//
//  MoviesCoordinator.swift
//  movies
//
//  Created by azun on 02/09/2023.
//

import UIKit
import Combine

protocol MoviesCoordinatorProtocol: AnyObject {
    var onFinished: AnyPublisher<Void, Never> { get }
    func finish()
    func watchTrailer(at address: String?)
}

class MoviesCoordinator: BaseCoordinator {
    private let finishedSubject = PassthroughSubject<Void, Never>()
}

extension MoviesCoordinator: MoviesCoordinatorProtocol {
    var onFinished: AnyPublisher<Void, Never> {
        finishedSubject.eraseToAnyPublisher()
    }
    
    func finish() {
        finishedSubject.send()
    }
    
    func watchTrailer(at address: String?) {
        let vc = TrailerViewController(urlString: address)
        navigationController?.present(vc, animated: true)
    }
}
