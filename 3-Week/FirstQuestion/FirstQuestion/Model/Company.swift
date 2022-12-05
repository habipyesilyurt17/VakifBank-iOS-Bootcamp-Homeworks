//
//  Company.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import Foundation

struct Company {
    let name: String
    let foundationYear: Int
    var revenue: Double
    var outgoing: Double
    var budget: Double
    var employees: [Employee] = []
}
