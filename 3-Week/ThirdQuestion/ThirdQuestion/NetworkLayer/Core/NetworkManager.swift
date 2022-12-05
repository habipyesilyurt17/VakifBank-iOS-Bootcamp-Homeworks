//
//  NetworkManager.swift
//  ThirdQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethods, completion: @escaping ((Result<T, ErrorTypes>)->())) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            session.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(.failure(.generalError))
                } else if let data = data {
                    self.handleResponse(data: data) { response in
                        completion(response)
                    }
                } else {
                    completion(.failure(.invalidURL))
                }
            }.resume()
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping ((Result<T, ErrorTypes>)->())) {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
