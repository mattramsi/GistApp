//
//  LuizaLabsTestSnapshotTests.swift
//  LuizaLabsTestSnapshotTests
//
//  Created by Matheus Ramos on 22/05/24.
//

import SnapshotTesting
import XCTest
@testable import GistApp

private class GistListCoordinatorSpy: GistListCoordinatorProtocol {
    var showGistDetailInvoked = false

    func showGistDetail(gist: Gist) {
        showGistDetailInvoked = true
    }
}

private class MockErrorProvider: PublicGistsProvider {
    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        completion(.failure(.unknownError))
    }
}

private class MockPublicGistsProvider: PublicGistsProvider {
    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        let gists: [Gist] = [Gist(
            id: "1",
            description: "",
            owner: Owner(
                login: "TestUser",
                avatar_url: ""
            ),
            files: [:]
        ),
         Gist(
            id: "2",
            description: "",
            owner: Owner(
                login: "luizalabs",
                avatar_url: ""
            ),
            files: [:]
         ), Gist(
            id: "3",
            description: "",
            owner: Owner(
                login: "magazineshow",
                avatar_url: ""
            ),
            files: [:]
         ), Gist(
            id: "4",
            description: "",
            owner: Owner(
                login: "luizaads",
                avatar_url: ""
            ),
            files: [:]
         )]
        completion(.success(gists))
    }
}

final class GistAppSnapshotTests: XCTestCase {

    func test_git_list_view_controller() {
        let coordinator = GistListCoordinatorSpy()
        let mockRepository = MockPublicGistsProvider()
        let viewModel = GistListViewModel(coordinator: coordinator, repository: mockRepository)
        let viewController = GistListViewController(viewModel: viewModel)
        viewController.loadView()
        viewController.viewDidLoad()

        assertSnapshot(matching: viewController.gistListView, as: .image(size: .init(width: 400, height: 400)), record: false)
    }

    func test_git_detal_view_controller() {
        let viewModel = GistDetailViewModel(gist: .mock)
        let viewController = GistDetailViewController(viewModel: viewModel)
        viewController.loadView()
        viewController.viewDidLoad()

        assertSnapshot(matching: viewController.gistDetailView, as: .image(size: .init(width: 400, height: 1_000)), record: false)
    }
}
