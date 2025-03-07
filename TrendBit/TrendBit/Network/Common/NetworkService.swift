//
//  NetworkService.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func request<T: Router, U: Decodable>(
        router: T,
        responseType: U.Type
    ) -> Single<Result<U, T.ErrorType>> {
        return Single<Result<U, T.ErrorType>>.create { observer in
            AF.request(router)
                .validate(statusCode: 200...299)
                .responseDecodable(of: U.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(.success(value)))
                        
                    case .failure(let error):
                        let error = router.throwError(error)
                        observer(.success(.failure(error)))
                    }
                }
            
            return Disposables.create()
        }
    }
}
