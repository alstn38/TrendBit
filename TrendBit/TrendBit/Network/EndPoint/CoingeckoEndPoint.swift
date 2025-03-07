//
//  CoingeckoEndPoint.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation
import Alamofire

enum CoingeckoEndPoint: Router {
    case trendInfo
    case search(query: String)
    case detail(id: String)
}

extension CoingeckoEndPoint {
    typealias ErrorType = CoingeckoAPIError
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.coingeckoBaseURL
    }
    
    var path: String {
        switch self {
        case .trendInfo:
            return "/search/trending"
        case .search:
            return "/search"
        case .detail:
            return "/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .trendInfo:
            return .get
        case .search:
            return .get
        case .detail:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .trendInfo:
            return nil
        case .search(let query):
            return [
                "query": query
            ]
        case .detail(let id):
            return [
                "vs_currency": "krw",
                "locale": "ko",
                "ids": id,
                "sparkline": true,
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url else {
            throw ErrorType.invalidURL
        }
        
        do {
            var request = try URLRequest(url: url, method: method, headers: headers)
            request = try URLEncoding.default.encode(request, with: parameters)
            return request
        } catch {
            throw ErrorType.badRequest
        }
    }
    
    func throwError(_ error: AFError) -> ErrorType {
        if error.underlyingError is DecodingError {
            return .decodeError
        }
        
        switch error.responseCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 429:
            return .tooManyRequest
        case 500:
            return .serverError
        case 503:
            return .serviceUnavailable
        case 1020:
            return .accessDenied
        case 10002:
            return .missingAPIKey
        case 10005:
            return .limitedProAPI
        default:
            return .unownedError
        }
    }
}
