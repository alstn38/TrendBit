//
//  UpbitAPIError.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import Foundation

enum UpbitAPIError: Error {
    case invalidURL
    case decodeError
    case badRequest
    case unownedError
}

extension UpbitAPIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .decodeError:
            return "decoded Error"
        case .badRequest: 
            return "400 Bad Request"
        case .unownedError:
            return "unownedError"
        }
    }
}
