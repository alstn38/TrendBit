//
//  TickerResponseDTOMapper.swift
//  TrendBit
//
//  Created by 강민수 on 4/19/25.
//

import Foundation

final class TickerResponseDTOMapper {
    
    func toEntity(from dto: TickerResponseDTO) -> ExchangeDataEntity {
        return ExchangeDataEntity(
            coinName: coinName(from: dto),
            currentPrice: currentPrice(from: dto),
            changePercent: changePercent(from: dto),
            changePrice: changePrice(from: dto),
            changeState: changeState(from: dto),
            transactionAmount: transactionAmount(from: dto)
        )
    }
    
    private func coinName(from dto: TickerResponseDTO) -> String {
        let nameArray = dto.code.components(separatedBy: "-")
        
        guard nameArray.count == 2 else {
            return dto.code
        }
        
        return nameArray[1] + "/" + nameArray[0]
    }
    
    private func currentPrice(from dto: TickerResponseDTO) -> String {
        return NumberFormatterManager.shared.pointNumberString(from: dto.tradePrice)
    }
    
    private func changePercent(from dto: TickerResponseDTO) -> String {
        return NumberFormatterManager.shared.percentString(from: dto.signedChangeRate)
    }
    
    private func changePrice(from dto: TickerResponseDTO) -> String {
        return NumberFormatterManager.shared.pointNumberString(from: dto.signedChangePrice)
    }
    
    private func changeState(from dto: TickerResponseDTO) -> ChangeState {
        if dto.change == "EVEN" {
            return .even
        } else if dto.change == "RISE" {
            return .rise
        } else {
            return .fall
        }
    }
    
    private func transactionAmount(from dto: TickerResponseDTO) -> String {
        return NumberFormatterManager.shared.millionString(from: dto.accTradePrice24h)
    }
}
