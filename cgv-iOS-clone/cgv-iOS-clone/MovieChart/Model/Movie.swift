//
//  Movie.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import Foundation

// MARK: - Movie

struct Movie: Codable {
    let posterPath: String
    let adult: Bool
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let backdropPath: String?
    let originalTitle, originalLanguage, title: String
    let popularity: Double
    let voteCount: Int
    let video: Bool?
    let voteAverage: Double
    let firstAirDate, name: String?
    let originCountry: [String]?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case adult, overview, name, id, title, popularity, video
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}
