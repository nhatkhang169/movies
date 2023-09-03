//
//  AppCoordinator.swift
//  movies
//
//  Created by azun on 29/08/2023.
//

import UIKit
import Combine

protocol AppCoordinatorProtocol: AnyObject {
    func gotoDetail(of movie: WatchListMovie)
}

class AppCoordinator: BaseCoordinator {
    override func start() {
        let moviesVC = MoviesViewController(viewModel: MoviesViewModel())
        moviesVC.coordinator = self
        navigationController = UINavigationController(rootViewController: moviesVC)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func gotoDetail(of movie: WatchListMovie) {
        let viewModel = MovieDetailViewModel(movie: movie)
        let movieVC = MovieDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(movieVC, animated: true)
        
        let moviesCoordinator = MoviesCoordinator()
        moviesCoordinator.navigationController = navigationController
        movieVC.coordinator = moviesCoordinator
        
        children.append(moviesCoordinator)
        registerMoviesCoordinator(with: moviesCoordinator)
    }
}

// MARK: - Private

private extension AppCoordinator {
    func registerMoviesCoordinator(with coordinator: MoviesCoordinatorProtocol) {
        coordinator.onFinished
            .sink { [weak self] _ in
                self?.children.removeLast()
            }
            .store(in: &disposeBag)
    }
}
