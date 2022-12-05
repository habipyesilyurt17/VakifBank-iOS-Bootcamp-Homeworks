//
//  Zoo.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

struct Zoo {
    let name: String
    let foundationYear: Int
    var revenue: Float
    var outgoing: Float
    var dailyWaterLimit: Float
    var budget: Float
    var animals: [Animal] = []
    var zookeepers: [Zookeeper] = []
}
