//
//  GistAppTests.swift
//  GistAppTests
//
//  Created by Matheus Ramos on 21/05/24.
//

import XCTest
@testable import GistApp

private class MockPublicGistsProvider: PublicGistsProvider {
    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        let gists: [Gist] = [.mock]
        completion(.success(gists))
    }
}

private class MockErrorProvider: PublicGistsProvider {
    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        completion(.failure(.unknownError))
    }
}

private class GistListCoordinatorSpy: GistListCoordinatorProtocol {
    var showGistDetailInvoked = false

    func showGistDetail(gist: Gist) {
        showGistDetailInvoked = true
    }
}

class GistListViewModelTests: XCTestCase {

    var viewModel: GistListViewModel!

    override func setUp() {
        super.setUp()
        let coordinator = GistListCoordinatorSpy()
        let mockRepository = MockPublicGistsProvider()
        viewModel = GistListViewModel(coordinator: coordinator, repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testShowGistDetail() {
        let coordinator = GistListCoordinatorSpy()
        let mockRepository = MockPublicGistsProvider()
        viewModel = GistListViewModel(coordinator: coordinator, repository: mockRepository)

        viewModel.showGistDetail(gist: .mock)

        XCTAssertTrue(coordinator.showGistDetailInvoked)
    }

    func testFetchGistsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch gists success")

        viewModel.onGistsFetched = {
            XCTAssertEqual(self.viewModel.gists.count, 1)
            XCTAssertEqual(self.viewModel.page, 1)
            expectation.fulfill()
        }

        viewModel.fetchGists()

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchGistsError() {
        let expectation = XCTestExpectation(description: "Fetch gists error")

        let coordinator = GistListCoordinatorSpy()
        let mockErrorRepository = MockErrorProvider()
        viewModel = GistListViewModel(coordinator: coordinator, repository: mockErrorRepository)

        viewModel.onError = { errorMessage in
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }

        viewModel.fetchGists()

        wait(for: [expectation], timeout: 5.0)
    }
}
