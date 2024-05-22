//
//  GistDetailViewController.swift
//  GistApp
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit

final class GistDetailViewController: UIViewController {
    // MARK: - Properties

    var viewModel: GistDetailViewModel
    var gistDetailView: GistDetailView!

    // MARK: - Initialization

    init(viewModel: GistDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        gistDetailView = GistDetailView()
        view = gistDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Configuration

    private func configureView() {
        navigationItem.title = "Gist Detail"
        gistDetailView.usernameLabel.text = viewModel.gist.owner.login
        gistDetailView.filesCountLabel.text = "Files: \(viewModel.gist.files.count)"
        if !viewModel.gist.owner.avatar_url.isEmpty {
            gistDetailView.avatarImageView.sd_setImage(with: URL(string: viewModel.gist.owner.avatar_url), completed: nil)
        }
    }
}
