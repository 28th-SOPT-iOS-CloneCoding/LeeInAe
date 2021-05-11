//
//  NetworkResponse.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import Foundation

struct NetworkResponse: Codable {
    let page: Int
    let results: [Movie]
    let dates: Dates?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates

struct Dates: Codable {
    let maximum, minimum: String
}
