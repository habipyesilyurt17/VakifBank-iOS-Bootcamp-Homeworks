//
//  CharacterQuotesManager.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import Foundation

class CharacterQuotesManager {
    static let shared = CharacterQuotesManager()
    
    func getQutoesByAuthor(author: String, completion: @escaping (Qutoe?, String?) -> Void ) {
        let authorFullName = author.split(separator: " ")
        let firstName      = authorFullName[0]
        let lastName       = authorFullName[1]

        let url = "\(NetworkHelper.shared.baseURL)/quote?author=\(firstName)+\(lastName)"
        NetworkManager.shared.request(type: Qutoe.self, url: url, method: .get) { response in
            switch response {
            case .success(let qutoes):
                completion(qutoes, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}

