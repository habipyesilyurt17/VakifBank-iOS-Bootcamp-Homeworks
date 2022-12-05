//
//  NetworkHelper.swift
//  Homework
//
//  Created by Habip Yesilyurt on 25.11.2022.
//

import Foundation

enum HTTPMethods: String {
    case get  = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL  = "Invalid url"
    case generalError = "An error happened"
}

struct NetworkHelper {
    static let shared = NetworkHelper()
    let baseURL = "https://www.breakingbadapi.com/api"
}
