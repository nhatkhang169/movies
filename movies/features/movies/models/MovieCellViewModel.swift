//
//  MovieCellViewModel.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import UIKit

protocol MovieCellViewModelProtocol {
    var title: String { get }
    var durationAndGenres: String { get }
    var isOnMyWatchList: Bool { get }
    var poster: UIImage? { get }
}

class MovieCellViewModel {
    private let movie: WatchListMovie
    init(movie: WatchListMovie) {
        self.movie = movie
    }
}

// MARK: - MovieCellViewModelProtocol
extension MovieCellViewModel: MovieCellViewModelProtocol {
    var title: String {
        "\(movie.movie.title) (\(movie.movie.releasedDate.year))"
    }
    
    var durationAndGenres: String {
        return [duration, genres]
            .filter({ $0 != ""})
            .joined(separator: " - ")
    }
    
    var isOnMyWatchList: Bool {
        movie.hasAddedToWatchList
    }
    
    var poster: UIImage? {
        guard let path = Bundle.main.path(forResource: movie.movie.poster, ofType: "png") else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
}

// MARK: - Private
private extension MovieCellViewModel {
    var duration: String {
        movie.movie.duration.toDuration()
    }
    
    var genres: String {
        movie.movie.genres
            .map({ $0.title })
            .joined(separator: ", ")
    }
}
