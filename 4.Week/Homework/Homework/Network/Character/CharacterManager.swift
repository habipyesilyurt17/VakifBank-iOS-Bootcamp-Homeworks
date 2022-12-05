//
//  CharacterManager.swift
//  Homework
//
//  Created by Habip Yesilyurt on 25.11.2022.
//

import Foundation

class CharacterManager {
    static let shared = CharacterManager()
    
    func getCharacters(completion: @escaping (Character?, String?) -> Void ) {
        let url = "\(NetworkHelper.shared.baseURL)/characters"
        NetworkManager.shared.request(type: Character.self, url: url, method: .get) { response in
            print("response = \(response)")
            switch response {
            case .success(let characters):
                completion(characters, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}
