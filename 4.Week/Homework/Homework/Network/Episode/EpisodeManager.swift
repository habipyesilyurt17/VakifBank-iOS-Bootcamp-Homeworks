//
//  EpisodeManager.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import Foundation

class EpisodeManager {
    static let shared = EpisodeManager()
    
    func getEpisodes(completion: @escaping (Season?, String?) -> Void ) {
        let url = "\(NetworkHelper.shared.baseURL)/episodes?series=Breaking+Bad"
        NetworkManager.shared.request(type: Season.self, url: url, method: .get) { response in
            switch response {
            case .success(let datas):
                completion(datas, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}
