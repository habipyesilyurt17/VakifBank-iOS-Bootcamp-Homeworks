//
//  QutoeModel.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import Foundation

struct QutoeModel: Codable {
    let quote: String
    let author: String
    let series: String
}

typealias Qutoe = [QutoeModel]
