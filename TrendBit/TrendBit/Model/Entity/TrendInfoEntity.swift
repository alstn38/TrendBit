//
//  TrendInfoEntity.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

struct TrendInfoEntity {
    let updateTime: String
    let trendCoinInfo: [TrendCoinInfo]
    let trendNFTInfo: [TrendNFTInfo]
}

struct TrendCoinInfo {
    let rank: Int
    let coinID: String
    let coinSymbol: String
    let coinName: String
    let thumbImageURLString: String
    let changePercent: String
    let changeState: ChangeState
}

struct TrendNFTInfo {
    let coinName: String
    let floorPrice: String
    let thumbImageURLString: String
    let changePercent: String
    let changeState: ChangeState
}
