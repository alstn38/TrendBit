//
//  CoingeckoAPIError.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import Foundation

enum CoingeckoAPIError: Error {
    case invalidURL
    case decodeError
    case badRequest
    case unauthorized
    case forbidden
    case tooManyRequest
    case serverError
    case serviceUnavailable
    case accessDenied
    case missingAPIKey
    case limitedProAPI
    case unownedError
}

extension CoingeckoAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .decodeError:
            return "decoded Error"
        case .badRequest:
            return "400 Bad Request"
        case .unauthorized:
            return "401 Unauthorized"
        case .forbidden:
            return "403 Forbidden"
        case .tooManyRequest:
            return "429 Too many requests"
        case .serverError:
            return "500 Internal Server Error"
        case .serviceUnavailable:
            return "503 Service Unavailable"
        case .accessDenied:
            return "1020 Access Denied"
        case .missingAPIKey:
            return "10002 Api Key Missing"
        case .limitedProAPI:
            return "10005 This request is limited Pro API subscribers"
        case .unownedError:
            return "unownedError"
        }
    }
}
