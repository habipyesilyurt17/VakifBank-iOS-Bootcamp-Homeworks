//
//  QuotesManager.swift
//  ThirdQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

class QuotesManager {
    static let shared = QuotesManager()
    
    func getQuotes(count: Int, index: Int, completion: @escaping ((Quotes?, String?)->())) {
        let url = "\(NetworkHelper.shared.baseURL)Quotes?count=\(count)"
        NetworkManager.shared.request(type: Quotes.self, url: url, method: .get) { response in
            switch response {
            case .success(let quotes):
                completion(quotes, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}
