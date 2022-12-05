//
//  SeasonModel.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import Foundation

struct SeasonModel: Codable {
    let episodeID: Int
    let title, season, airDate: String
    let characters: [String]
    let episode: String

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode
    }
}

typealias Season = [SeasonModel]
