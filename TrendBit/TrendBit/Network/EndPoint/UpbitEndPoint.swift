//
//  UpbitEndPoint.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation
import Alamofire

enum UpbitEndPoint: Router {
    case marketData
}

extension UpbitEndPoint {
    typealias ErrorType = UpbitAPIError
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.upbitBaseURL
    }
    
    var path: String {
        switch self {
        case .marketData:
            return "/ticker/all"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .marketData:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        switch self {
        case .marketData:
            return [
                "quote_currencies": "KRW"
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
        default:
            return .unownedError
        }
    }
}
