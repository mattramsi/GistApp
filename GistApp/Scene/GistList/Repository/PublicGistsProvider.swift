//
//  NetworkManager.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import Foundation

protocol PublicGistsProvider {
    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void)
}

final class PublicGistsRepository: PublicGistsProvider {
    // MARK: - Properties

    private let baseURL: URL
    private let session: URLSession

    // MARK: - Initialization

    init(baseURL: URL = URL(string: "https://api.github.com/gists/public")!,
         session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    // MARK: - Public Methods

    func fetchPublicGists(page: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)")]

        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.unknownError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }

            guard 200...299 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let gists = try JSONDecoder().decode([Gist].self, from: data)
                completion(.success(gists))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
}
