//
//  Secret.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import Foundation

enum Secret {
    
    static let upbitBaseURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["UPBIT_BASE_URL"] as? String else {
            fatalError("UPBIT_BASE_URL ERROR")
        }
        
        return urlString
    }()
    
    static let upbitSoketURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["UPBIT_SOKET_URL"] as? String else {
            fatalError("UPBIT_SOKET_URL ERROR")
        }
        
        return urlString
    }()
    
    static let coingeckoBaseURL: String = {
        guard let urlString = Bundle.main.infoDictionary?["COINGECKO_BASE_URL"] as? String else {
            fatalError("COINGECKO_BASE_URL ERROR")
        }
        
        return urlString
    }()
}
