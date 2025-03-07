//
//  TrendInfoDTO.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

struct TrendInfoDTO: Decodable {
    let coins: [TrendingCoinItem]
    let nfts: [TrendingNFTItem]
}

struct TrendingCoinItem: Decodable {
    let item: TrendingCoinDetails
}

struct TrendingCoinDetails: Decodable {
    let id: String
    let coinID: Int
    let name: String
    let symbol: String
    let marketCapRank: Int
    let thumb: String
    let small: String
    let large: String
    let slug: String
    let priceBtc: Double
    let score: Int
    let data: TrendingCoinData

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
        case small
        case large
        case slug
        case priceBtc = "price_btc"
        case score
        case data
    }
}

struct TrendingCoinData: Decodable {
    let price: Double
    let priceBtc: String
    let priceChangePercentage24H: [String: Double]
    let marketCap, marketCapBtc, totalVolume, totalVolumeBtc: String
    let sparkline: String
    let content: Content?

    enum CodingKeys: String, CodingKey {
        case price
        case priceBtc = "price_btc"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case sparkline, content
    }
}

struct Content: Decodable {
    let title, description: String
}

struct TrendingNFTItem: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency: Double
    let floorPrice24HPercentageChange: Double
    let data: TrendingNFTData

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case thumb
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

struct TrendingNFTData: Decodable {
    let floorPrice: String
    let floorPriceInUsd24HPercentageChange: String
    let h24Volume: String
    let h24AverageSalePrice: String
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
        case sparkline
    }
}
