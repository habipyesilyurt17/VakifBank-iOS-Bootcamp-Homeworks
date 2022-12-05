//
//  CharacterModel.swift
//  Homework
//
//  Created by Habip Yesilyurt on 25.11.2022.
//

import Foundation

struct CharacterModel: Codable {
    let charId: Int
    let name: String
    let birthday: String
    let nickname: String
    let img: String
    let portrayed: String
    
    enum CodingKeys: String, CodingKey {
        case charId = "char_id"
        case name, birthday, nickname, img, portrayed
    }
}

typealias Character = [CharacterModel]
