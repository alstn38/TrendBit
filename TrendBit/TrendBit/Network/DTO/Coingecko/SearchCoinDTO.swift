//
//  SearchCoinDTO.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

struct SearchCoinDTO: Decodable {
    let coins: [SearchCoinDetail]
}

struct SearchCoinDetail: Decodable {
    let id: String
    let name: String
    let apiSymbol: String
    let symbol: String
    let marketCapRank: Int
    let thumb: String
    let large: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
        case large
    }
}

// MARK: - To Entity Method
extension SearchCoinDTO {
    
    func toEntity() -> [SearchCoinEntity] {
        let mapper = SearchCoinDTOMapper()
        return mapper.toEntity(from: self)
    }
}
