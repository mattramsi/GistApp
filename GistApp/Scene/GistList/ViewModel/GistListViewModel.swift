//
//  GistListViewModel.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import Foundation

final class GistListViewModel {
    // MARK: - Properties

    var gists: [Gist] = []
    var page = 0
    var isLoading = false

    var onGistsFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    private let repository: PublicGistsProvider
    private let coordinator: GistListCoordinatorProtocol?

    // MARK: - Initialization

    init(coordinator: GistListCoordinatorProtocol?, repository: PublicGistsProvider) {
        self.repository = repository
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func fetchGists() {
        guard !isLoading else { return }
        isLoading = true
        repository.fetchPublicGists(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let gists):
                self.handleSuccessfulResponse(gists)
            case .failure(let error):
                self.handle(error: error)
            }
        }
    }

    // MARK: - Private Methods

    private func handleSuccessfulResponse(_ gists: [Gist]) {
        gists.forEach { gist in
            self.gists.append(gist)
        }
        page += 1
        onGistsFetched?()
    }

    private func handle(error: NetworkError) {
        switch error {
        case .invalidURL:
            onError?("Invalid URL")
        case .noData:
            onError?("No data received from the server")
        case .decodingError:
            onError?("Failed to decode the response")
        case .serverError(let statusCode):
            onError?("Server error with status code: \(statusCode)")
        case .unknownError:
            onError?("An unknown error occurred")
        }
    }

    func showGistDetail(gist: Gist) {
        coordinator?.showGistDetail(gist: gist)
    }
}
