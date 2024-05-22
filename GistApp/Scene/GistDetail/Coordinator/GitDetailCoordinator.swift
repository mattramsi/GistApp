//
//  CoordinatorGitDetailFlowController.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 22/05/24.
//

import UIKit

protocol GitDetailCoordinatorProtocol: AnyObject { }

final class GitDetailCoordinator: Coordinator, GitDetailCoordinatorProtocol {
    // MARK: - Properties

    var navigationController: UINavigationController
    var gist: Gist

    // MARK: - Initialization

    init(navigationController: UINavigationController, gist: Gist) {
        self.navigationController = navigationController
        self.gist = gist
    }

    // MARK: - Coordinator

    func start() {
        navigationController.pushViewController(GistDetailFactory.make(gist: gist), animated: true)
    }
}
