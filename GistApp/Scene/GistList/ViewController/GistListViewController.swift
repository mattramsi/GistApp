//
//  GistListViewController.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit

final class GistListViewController: UIViewController {
    // MARK: - Properties

    var viewModel: GistListViewModel
    var gistListView: GistListView!

    // MARK: - Initialization

    init(viewModel: GistListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        gistListView = GistListView()
        view = gistListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gist List"

        setupTableView()
        bindViewModel()
        viewModel.fetchGists()
    }

    // MARK: - Setup

    private func setupTableView() {
        gistListView.tableView.delegate = self
        gistListView.tableView.dataSource = self
        gistListView.tableView.register(GistTableViewCell.self,
                                        forCellReuseIdentifier: GistTableViewCell.identifier)
    }

    private func bindViewModel() {
        viewModel.onGistsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.gistListView.tableView.reloadData()
            }
        }

        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: errorMessage)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension GistListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GistTableViewCell.identifier, for: indexPath) as! GistTableViewCell
        let gist = viewModel.gists[indexPath.row]
        cell.configure(with: gist)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gist = viewModel.gists[indexPath.row]
        viewModel.showGistDetail(gist: gist)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if position > contentHeight - scrollViewHeight - 100 {
            viewModel.fetchGists()
        }
    }
}
