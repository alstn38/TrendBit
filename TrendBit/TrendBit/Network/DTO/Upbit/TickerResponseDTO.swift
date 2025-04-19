//
//  TickerResponseDTO.swift
//  TrendBit
//
//  Created by 강민수 on 4/19/25.
//

import Foundation

struct TickerResponseDTO: Decodable {
    let code: String
    let tradePrice: Double
    let change: String
    let signedChangePrice: Double
    let signedChangeRate: Double
    let accTradePrice24h: Double

    enum CodingKeys: String, CodingKey {
        case code = "cd"
        case tradePrice = "tp"
        case change = "c"
        case signedChangePrice = "scp"
        case signedChangeRate = "scr"
        case accTradePrice24h = "atp24h"
    }
}

extension TickerResponseDTO {
    
    func toEntity() -> ExchangeDataEntity {
        let mapper = TickerResponseDTOMapper()
        return mapper.toEntity(from: self)
    }
}
