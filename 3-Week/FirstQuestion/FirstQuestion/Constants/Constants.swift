//
//  Constants.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import Foundation

enum MaritalStatus: String {
    case single = "Single"
    case married = "Married"
}

enum EmployeeTypes: String {
    case jr  = "Junior"
    case mid = "Middle"
    case sr  = "Senior"
}

enum EmployeeExperience: String {
    case jr  = "2"
    case mid = "4"
    case sr  = "6"
}

enum EmployeePositions: String {
    case ios      = "İOS Developer"
    case backEnd  = "Back-End Developer"
    case frontEnd = "Front-End Developer"
}

enum StaticSalaryValues: Float {
    case jrSalary  = 5_000
    case midSalary = 10_000
    case srSalary  = 15_000
}
