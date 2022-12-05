//
//  QuotesModel.swift
//  ThirdQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

struct Quote: Codable {
    let id: String
    let author: String
    let en: String
}

typealias Quotes = [Quote]
