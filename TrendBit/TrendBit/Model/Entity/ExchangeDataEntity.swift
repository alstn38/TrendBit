//
//  ExchangeDataEntity.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

struct ExchangeDataEntity {
    let coinName: String
    let currentPrice: String
    let changePercent: String
    let changePrice: String
    let changeState: ChangeState
    let transactionAmount: String
}

extension ExchangeDataEntity {
    
    enum ChangeState {
        case rise
        case fall
        case even
    }
}
