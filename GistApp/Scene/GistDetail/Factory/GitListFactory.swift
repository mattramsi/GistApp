//
//  GitListFactory.swift
//  GistApp
//
//  Created by Matheus Ramos on 22/05/24.
//

import Foundation

enum GistListFactory {
    static func make(coordinator: GistListCoordinatorProtocol?) -> GistListViewController {
        let repository = PublicGistsRepository()
        let viewModel = GistListViewModel(coordinator: coordinator, repository: repository)
        return GistListViewController(viewModel: viewModel)
    }
}
