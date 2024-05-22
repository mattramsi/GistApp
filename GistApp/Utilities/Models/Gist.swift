//
//  Gist.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import Foundation

struct Gist: Decodable {
    let id: String
    let description: String?
    let owner: Owner
    let files: [String: GistFile]

    static var mock: Gist {
        Gist(
            id: "1",
            description: "",
            owner: Owner(
                login: "TestUser",
                avatar_url: ""
            ),
            files: [:]
        )
    }
}

struct Owner: Decodable {
    let login: String
    let avatar_url: String
}

struct GistFile: Decodable {
    let filename: String
}
