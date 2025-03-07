//
//  Router.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    associatedtype ErrorType: Error
    
    var url: URL? { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func throwError(_ error: AFError) -> ErrorType
}
