//
//  NetworkError.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknownError
}
