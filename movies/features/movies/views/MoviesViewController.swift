//
//  MoviesViewController.swift
//  movies
//
//  Created by azun on 29/08/2023.
//

import UIKit
import Combine

class MoviesViewController: BaseViewController {
    private(set) var viewModel: MoviesViewModelProtocol?
    weak var coordinator: AppCoordinatorProtocol?
    private var disposeBag = Set<AnyCancellable>()
    
    convenience init(viewModel: MoviesViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private(set) lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.cellId)
        return table
    }()
}

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.movie(at: indexPath.row) else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellId) as? MovieCell else { return UITableViewCell() }
        cell.configure(with: MovieCellViewModel(movie: item))
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = viewModel?.movie(at: indexPath.row) else { return }
        coordinator?.gotoDetail(of: item)
    }
}

// MARK: - Private
private extension MoviesViewController {
    func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    func setupNavBar() {
        title = L10n.Movies.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.Movies.Button.sort,
                                                            style: .plain, target: self,
                                                            action: #selector(sortTapped))

    }
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reload() {
        viewModel?.fetch()
        tableView.reloadData()
        shouldShowSpinner = false
    }
    
    func handleUpdates() {
        if navigationController?.topViewController is MoviesViewController {
            shouldShowSpinner = true
        }
        // simulate network effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.reload()
        }
    }
    
    func setupBindings() {
        viewModel?.onUpdated
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.handleUpdates()
            })
            .store(in: &disposeBag)
    }
    
    @objc func sortTapped() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: L10n.Movies.SortBy.title,style: .default, handler: { [weak self] _ in
            self?.viewModel?.sortedBy = .title
        }))
        actionSheet.addAction(UIAlertAction(title: L10n.Movies.SortBy.releasedDate, style: .default, handler: { [weak self] _ in
            self?.viewModel?.sortedBy = .releasedDate
        }))
        actionSheet.addAction(UIAlertAction(title: L10n.Movies.SortBy.cancel, style: .cancel))
        actionSheet.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(actionSheet, animated: true)
    }
}
