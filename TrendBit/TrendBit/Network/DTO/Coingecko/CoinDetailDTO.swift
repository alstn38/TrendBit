//
//  CoinDetailDTO.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

struct CoinDetailDTO: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Int
    let marketCap: Int
    let marketCapRank: Int
    let fullyDilutedValuation: Int
    let totalVolume: Int
    let high24H: Int
    let low24H: Int
    let priceChange24H: Double
    let priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply: Int
    let totalSupply: Int
    let maxSupply: Int
    let ath: Int
    let athChangePercentage: Double
    let athDate: String
    let atl: Int
    let atlChangePercentage: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7D: SparklineIn7D

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
    }
}

struct SparklineIn7D: Decodable {
    let price: [Double]
}
