//
//  Coordinator.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit

protocol Coordinator {

  var navigationController: UINavigationController { get set }

  func start()

}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainCoordinator = GistListCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
}
