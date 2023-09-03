//
//  MoviesViewModel.swift
//  movies
//
//  Created by azun on 29/08/2023.
//

import Combine

protocol MoviesViewModelProtocol {
    var numberOfRows: Int { get }
    var onUpdated: AnyPublisher<Void, Never> { get }
    var sortedBy: SortType { get set }
    func fetch()
    func movie(at index: Int) -> WatchListMovie?
}

enum SortType {
    case none
    case title
    case releasedDate
}

enum SortOrder {
    case asc
    case desc
}

class MoviesViewModel {
    private var moviesList = [WatchListMovie]()
    
    private let repo: MovieRepoProtocol
    private let updatedSubject = PassthroughSubject<Void, Never>()
    private var disposeBag = Set<AnyCancellable>()
    
    init(repo: MovieRepoProtocol = MovieRepo()) {
        self.repo = repo
        setupBindings()
    }
    
    var sortedBy: SortType = .none {
        didSet {
            if oldValue == sortedBy {
                sortOrder = sortOrder == .asc ? .desc : .asc
            }
            else {
                sortOrder = .asc
            }
            fetch()
            updatedSubject.send()
        }
    }
    
    private var sortOrder: SortOrder = .asc
}

// MARK: - MoviesViewModelProtocol

extension MoviesViewModel: MoviesViewModelProtocol {
    var numberOfRows: Int {
        moviesList.count
    }
    
    var onUpdated: AnyPublisher<Void, Never> {
        updatedSubject.eraseToAnyPublisher()
    }
    
    func movie(at index: Int) -> WatchListMovie? {
        moviesList[safe: index]
    }
    
    func fetch() {
        moviesList = repo.watchListMovies(sortedBy: sortedBy, sortOrder: sortOrder)
    }
    
    func setupBindings() {
        repo.onUpdated
            .sink { [weak self] _ in
                self?.updatedSubject.send()
            }
            .store(in: &disposeBag)
        repo.startObservingChanges()
    }
}
