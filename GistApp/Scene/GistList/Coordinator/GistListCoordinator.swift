//
//  CoordinatorGitListFlowController.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 22/05/24.
//

import UIKit

protocol GistListCoordinatorProtocol: AnyObject {
    func showGistDetail(gist: Gist)
}

final class GistListCoordinator: GistListCoordinatorProtocol {
    // MARK: - Properties

    var navigationController: UINavigationController

    // MARK: - Initialization

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator Methods

    func start() {
        navigationController.pushViewController(
            GistListFactory.make(
                coordinator: self
            ),
            animated: false
        )
    }

    // MARK: - GistListCoordinatorProtocol

    func showGistDetail(gist: Gist) {
        let coordinator = GitDetailCoordinator(navigationController: navigationController,
                                               gist: gist)
        coordinator.start()
    }
}
