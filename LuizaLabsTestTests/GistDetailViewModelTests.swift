//
//  GistDetailViewModelTests.swift
//  LuizaLabsTestTests
//
//  Created by Matheus Ramos on 22/05/24.
//

import XCTest
@testable import LuizaLabsTest

final class GistDetailViewModelTests: XCTestCase {

    func testGistDetailViewModelInitialization() {
        let viewModel = GistDetailViewModel(gist: .mock)

        XCTAssertEqual(viewModel.gist.id, "1")
        XCTAssertEqual(viewModel.gist.owner.login, "TestUser")
    }
}
