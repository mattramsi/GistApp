//
//  GistDetailFactory.swift
//  GistApp
//
//  Created by Matheus Ramos on 22/05/24.
//

import Foundation

enum GistDetailFactory {
    static func make(gist: Gist) -> GistDetailViewController {
        let viewModel = GistDetailViewModel(gist: gist)
        return GistDetailViewController(viewModel: viewModel)
    }
}
