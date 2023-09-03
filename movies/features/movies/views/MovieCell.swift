//
//  MovieCell.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import UIKit

protocol MovieCellProtocol {
    func configure(with viewModel: MovieCellViewModelProtocol)
}

class MovieCell: UITableViewCell {
    static let cellId = "Movie.Cell"
    
    private enum Constants {
        static let cornerRadius = CGFloat(8)
        static let padding = CGFloat(20)
        static let titleDurationVSpace = CGFloat(5)
        static let posterwWidth = CGFloat(100)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        titleLabel.text = nil
        durationAndGenresLabel.text = nil
        onWatchListLabel.isHidden = true
    }
    
    private lazy var poster: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var posterContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowColor = UIColor.label.cgColor
        return view
    }()
    
    private lazy var durationAndGenresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var onWatchListLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = L10n.Movies.Label.onMyWatchList
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - MovieCellProtocol
extension MovieCell: MovieCellProtocol {
    func configure(with viewModel: MovieCellViewModelProtocol) {
        poster.image = viewModel.poster
        durationAndGenresLabel.text = viewModel.durationAndGenres
        titleLabel.text = viewModel.title
        onWatchListLabel.isHidden = !viewModel.isOnMyWatchList
    }
}

// MARK: - Private
private extension MovieCell {
    func setupUI() {
        setupPoster()
        setupDurationLabel()
        setupTitleLabel()
        setupOnWatchListLabel()
    }
    
    func setupPoster() {
        contentView.addSubview(posterContainer)
        posterContainer.addSubview(poster)
        NSLayoutConstraint.activate([
            posterContainer.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Constants.padding),
            posterContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            posterContainer.widthAnchor.constraint(equalToConstant: Constants.posterwWidth),
            posterContainer.heightAnchor.constraint(equalTo: posterContainer.widthAnchor, multiplier: 1.5),
            
            poster.leadingAnchor.constraint(equalTo: posterContainer.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: posterContainer.trailingAnchor),
            poster.topAnchor.constraint(equalTo: posterContainer.topAnchor),
            poster.bottomAnchor.constraint(equalTo: posterContainer.bottomAnchor)
        ])
    }
    
    func setupDurationLabel() {
        contentView.addSubview(durationAndGenresLabel)
        NSLayoutConstraint.activate([
            durationAndGenresLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            durationAndGenresLabel.leadingAnchor.constraint(equalTo: posterContainer.trailingAnchor, constant: Constants.padding),
            durationAndGenresLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Constants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: durationAndGenresLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: durationAndGenresLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: durationAndGenresLabel.topAnchor, constant: -Constants.titleDurationVSpace)
        ])
    }
    
    func setupOnWatchListLabel() {
        contentView.addSubview(onWatchListLabel)
        NSLayoutConstraint.activate([
            onWatchListLabel.topAnchor.constraint(greaterThanOrEqualTo: durationAndGenresLabel.bottomAnchor),
            onWatchListLabel.leadingAnchor.constraint(equalTo: durationAndGenresLabel.leadingAnchor),
            onWatchListLabel.trailingAnchor.constraint(equalTo: durationAndGenresLabel.trailingAnchor),
            onWatchListLabel.bottomAnchor.constraint(lessThanOrEqualTo: poster.bottomAnchor, constant: -Constants.padding)
        ])
    }
}
