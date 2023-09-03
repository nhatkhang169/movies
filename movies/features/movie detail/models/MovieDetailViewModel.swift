//
//  MovieDetailViewModel.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import UIKit
import Combine

protocol MovieDetailViewModelProtocol {
    var desc: String { get }
    var poster: UIImage? { get }
    var rating: String { get }
    var title: String { get }
    var watchListButtonText: String { get }
    var genres: String { get }
    var releasedDateText: String { get }
    var trailer: String { get }
    
    var onMovieUpdated: AnyPublisher<Void, Never> { get }
    
    func toggleInWatchList()
}

class MovieDetailViewModel {
    private(set) var movie: WatchListMovie
    private let repo: MovieRepoProtocol
    private let movieUpdateSubject = PassthroughSubject<Void, Never>()
    
    init(movie: WatchListMovie, repo: MovieRepoProtocol = MovieRepo()) {
        self.movie = movie
        self.repo = repo
    }
}

// MARK: - MovieDetailViewModelProtocol

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    var poster: UIImage? {
        guard let path = Bundle.main.path(forResource: movie.movie.poster, ofType: "png") else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    var title: String {
        movie.movie.title
    }
    
    var rating: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: movie.movie.rating)) ?? "0"
    }
    
    var watchListButtonText: String {
        movie.hasAddedToWatchList
            ? L10n.MovieDetail.Button.removeFromWatchList
            : L10n.MovieDetail.Button.addToWatchList
    }
    
    var desc: String {
        movie.movie.desc
    }
    
    var genres: String {
        movie.movie.genres
            .map({ $0.title })
            .joined(separator: ", ")
    }
    
    var releasedDateText: String {
        movie.movie.releasedDate.toString()
    }
    
    var trailer: String {
        movie.movie.trailer
    }
    
    var onMovieUpdated: AnyPublisher<Void, Never> {
        movieUpdateSubject.eraseToAnyPublisher()
    }
    
    func toggleInWatchList() {
        repo.toggleInWatchList(id: movie.movie.id)
        if let newMovie = repo.watchListMovies(sortedBy: .none,
                                               sortOrder: .asc).first(where: {
            $0.movie.id == movie.movie.id
        }) {
            movie = newMovie
            movieUpdateSubject.send()
        }
    }
}
