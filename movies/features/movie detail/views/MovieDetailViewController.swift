//
//  MovieDetailViewController.swift
//  movies
//
//  Created by azun on 01/09/2023.
//

import Foundation
import UIKit
import Combine

class MovieDetailViewController: UIViewController {
    private enum Constants {
        static let cornerRadius = CGFloat(8)
        static let padding = CGFloat(20)
        static let separatorHSpace = CGFloat(16)
        static let posterwWidth = CGFloat(140)
        static let titleMargin = CGFloat(5)
        static let ratingWidth = CGFloat(40)
        static let buttonHeight = CGFloat(40)
        static let separatorHeight = CGFloat(1)
    }
    
    private(set) var viewModel: MovieDetailViewModelProtocol?
    weak var coordinator: MoviesCoordinatorProtocol?
    
    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    deinit {
        print("denit - MovieDetailViewController")
        coordinator?.finish()
    }
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.bounces = true
        view.isScrollEnabled = true
        return view
    }()
    
    private lazy var poster: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        view.image = viewModel?.poster
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = viewModel?.title
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = viewModel?.rating
        return label
    }()
    
    private lazy var perRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.text = "/10"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addToWatchListButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.background.backgroundColor = .quaternaryLabel
        config.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        let button = UIButton(configuration: config, primaryAction: UIAction() { [weak self] _ in
            self?.addToWatchList()
        })
        button.configurationUpdateHandler = { $0.updateState(normalColor: .quaternaryLabel) }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1900
        return button
    }()
    
    private lazy var watchTrailerButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.cornerStyle = .capsule
        config.background.strokeColor = .label
        config.background.strokeWidth = 1
        config.background.backgroundColor = .systemBackground
        config.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        config.attributedTitle = AttributedString(L10n.MovieDetail.Button.watchTrailer,
                                                  attributes: AttributeContainer([
                                                    .font: UIFont.systemFont(ofSize: 11),
                                                    .foregroundColor: UIColor.label
                                                  ]))
        let button = UIButton(configuration: config, primaryAction: UIAction() { [weak self] _ in
            self?.watchTrailer()
        })
        button.configurationUpdateHandler = { $0.updateState() }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1901
        return button
    }()
    
    private lazy var shortDescTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = L10n.MovieDetail.shortDesc
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shortDescLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.text = viewModel?.desc
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var topSeparator = createSeparatorView()
    private lazy var bottomSeparator = createSeparatorView()
    
    private lazy var detailsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = L10n.MovieDetail.details
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = L10n.MovieDetail.genre
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var releasedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = L10n.MovieDetail.releaseDate
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var genresListLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.text = viewModel?.genres
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private lazy var releasedDateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16)
        label.text = viewModel?.releasedDateText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private var disposeBag = Set<AnyCancellable>()
}

// MARK: - Private
private extension MovieDetailViewController {
    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupPoster()
        setupTitleLabel()
        setupRatingLabel()
        setupPerRatingLabel()
        setupAddToWatchListButton()
        setupWatchTrailerButton()
        setupTopSeparator()
        setupShortDesc()
        setupBottomSeparator()
        setupDetailsLabel()
        setupGenreLabel()
        setupReleasedDateLabel()
        setupGenresList()
        setupReleasedDateText()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupPoster() {
        scrollView.addSubview(posterContainer)
        posterContainer.addSubview(poster)
        NSLayoutConstraint.activate([
            posterContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.padding),
            posterContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.padding),
            posterContainer.widthAnchor.constraint(equalToConstant: Constants.posterwWidth),
            posterContainer.heightAnchor.constraint(equalTo: posterContainer.widthAnchor, multiplier: 1.5),
            
            poster.leadingAnchor.constraint(equalTo: posterContainer.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: posterContainer.trailingAnchor),
            poster.topAnchor.constraint(equalTo: posterContainer.topAnchor),
            poster.bottomAnchor.constraint(equalTo: posterContainer.bottomAnchor)
        ])
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterContainer.topAnchor, constant: Constants.titleMargin),
            titleLabel.leadingAnchor.constraint(equalTo: posterContainer.trailingAnchor, constant: Constants.padding)
        ])
    }
    
    func setupRatingLabel() {
        scrollView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            ratingLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: Constants.ratingWidth),
        ])
    }
    
    func setupPerRatingLabel() {
        scrollView.addSubview(perRatingLabel)
        NSLayoutConstraint.activate([
            perRatingLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            perRatingLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            perRatingLabel.widthAnchor.constraint(equalToConstant: Constants.ratingWidth),
            perRatingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupAddToWatchListButton() {
        scrollView.addSubview(addToWatchListButton)
        NSLayoutConstraint.activate([
            addToWatchListButton.centerYAnchor.constraint(equalTo: posterContainer.centerYAnchor),
            addToWatchListButton.leadingAnchor.constraint(equalTo: posterContainer.trailingAnchor, constant: Constants.padding),
            addToWatchListButton.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            addToWatchListButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            addToWatchListButton.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: Constants.padding),
        ])
        
        updateAddToWatchListButton()
    }
    
    func setupWatchTrailerButton() {
        scrollView.addSubview(watchTrailerButton)
        NSLayoutConstraint.activate([
            watchTrailerButton.topAnchor.constraint(equalTo: addToWatchListButton.bottomAnchor, constant: Constants.padding),
            watchTrailerButton.leadingAnchor.constraint(equalTo: addToWatchListButton.leadingAnchor),
            watchTrailerButton.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            watchTrailerButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    func addToWatchList() {
        viewModel?.toggleInWatchList()
    }
    
    func watchTrailer() {
        coordinator?.watchTrailer(at: viewModel?.trailer)
    }
    
    func createSeparatorView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiaryLabel
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = UIColor.label.cgColor
        return view
    }
    
    func setupTopSeparator() {
        scrollView.addSubview(topSeparator)
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: posterContainer.bottomAnchor, constant: Constants.padding),
            topSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.separatorHSpace),
            topSeparator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.separatorHSpace),
            topSeparator.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        ])
    }
    
    func setupShortDesc() {
        scrollView.addSubview(shortDescTitleLabel)
        scrollView.addSubview(shortDescLabel)
        NSLayoutConstraint.activate([
            shortDescTitleLabel.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: Constants.padding),
            shortDescTitleLabel.leadingAnchor.constraint(equalTo: posterContainer.leadingAnchor),
            shortDescTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            
            shortDescLabel.topAnchor.constraint(equalTo: shortDescTitleLabel.bottomAnchor, constant: Constants.padding),
            shortDescLabel.leadingAnchor.constraint(equalTo: shortDescTitleLabel.leadingAnchor),
            shortDescLabel.trailingAnchor.constraint(equalTo: shortDescTitleLabel.trailingAnchor)
        ])
    }
    
    func setupBottomSeparator() {
        scrollView.addSubview(bottomSeparator)
        NSLayoutConstraint.activate([
            bottomSeparator.topAnchor.constraint(equalTo: shortDescLabel.bottomAnchor, constant: Constants.padding),
            bottomSeparator.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.separatorHSpace),
            bottomSeparator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.separatorHSpace),
            bottomSeparator.heightAnchor.constraint(equalToConstant: Constants.separatorHeight)
        ])
    }
    
    func setupDetailsLabel() {
        scrollView.addSubview(detailsTitleLabel)
        NSLayoutConstraint.activate([
            detailsTitleLabel.topAnchor.constraint(equalTo: bottomSeparator.bottomAnchor, constant: Constants.padding),
            detailsTitleLabel.leadingAnchor.constraint(equalTo: shortDescTitleLabel.leadingAnchor),
            detailsTitleLabel.trailingAnchor.constraint(equalTo: shortDescTitleLabel.trailingAnchor)
        ])
    }
    
    func setupGenreLabel() {
        scrollView.addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: detailsTitleLabel.bottomAnchor, constant: Constants.padding / 2),
            genreLabel.leadingAnchor.constraint(equalTo: shortDescTitleLabel.leadingAnchor),
            genreLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.333)
        ])
    }
    
    func setupReleasedDateLabel() {
        scrollView.addSubview(releasedDateLabel)
        NSLayoutConstraint.activate([
            releasedDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: Constants.padding / 3),
            releasedDateLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            releasedDateLabel.widthAnchor.constraint(equalTo: genreLabel.widthAnchor)
        ])
    }
    
    func setupGenresList() {
        scrollView.addSubview(genresListLabel)
        NSLayoutConstraint.activate([
            genresListLabel.centerYAnchor.constraint(equalTo: genreLabel.centerYAnchor),
            genresListLabel.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: Constants.padding / 3),
            genresListLabel.trailingAnchor.constraint(equalTo: shortDescTitleLabel.trailingAnchor)
        ])
    }
    
    func setupReleasedDateText() {
        scrollView.addSubview(releasedDateTextLabel)
        NSLayoutConstraint.activate([
            releasedDateTextLabel.centerYAnchor.constraint(equalTo: releasedDateLabel.centerYAnchor),
            releasedDateTextLabel.leadingAnchor.constraint(equalTo: genresListLabel.leadingAnchor),
            releasedDateTextLabel.trailingAnchor.constraint(equalTo: genresListLabel.trailingAnchor),
            releasedDateTextLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.padding)
        ])
    }
    
    func setupBindings() {
        viewModel?.onMovieUpdated
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.updateAddToWatchListButton()
            })
            .store(in: &disposeBag)
    }
    
    func updateAddToWatchListButton() {
        var config = addToWatchListButton.configuration
        config?.attributedTitle = AttributedString(viewModel?.watchListButtonText ?? "",
                                                   attributes: AttributeContainer([
                                                    .font: UIFont.systemFont(ofSize: 11),
                                                    .foregroundColor: UIColor.secondaryLabel
                                                   ]))
        addToWatchListButton.configuration = config
    }
}
