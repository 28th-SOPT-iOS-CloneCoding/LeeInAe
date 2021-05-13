//
//  MovieService.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import Foundation
import Moya

enum MovieService {
    static let apiKey = "324d8aa817aaa5f3aeffef566e892eb7"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    case getPopular(page: Int)
    case getTrend(page: Int)
    case getUpcoming(page: Int)
}

extension MovieService: TargetType {
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getPopular:
            return "/movie/popular"
        case .getTrend:
            return "/trending/movie/week"
        case .getUpcoming:
            return "/movie/upcoming"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopular, .getTrend, .getUpcoming:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getPopular(let page):
            return .requestParameters(parameters: ["api_key": MovieService.apiKey, "language": "ko", "page": page], encoding: URLEncoding.default)
        case .getTrend(page: let page):
            return .requestParameters(parameters: ["api_key": MovieService.apiKey, "language": "ko", "page": page], encoding: URLEncoding.default)
        case .getUpcoming(page: let page):
            return .requestParameters(parameters: ["api_key": MovieService.apiKey, "language": "ko", "page": page, "region": "KR"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}
