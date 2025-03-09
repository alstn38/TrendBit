//
//  TrendInfoDTOMapper.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

final class TrendInfoDTOMapper {
    
    func toEntity(from dto: TrendInfoDTO) -> TrendInfoEntity {
        
        return TrendInfoEntity(
            updateTime: DateFormatterManager.shared.trendUpdateTimeString(date: Date()),
            trendCoinInfo: trendCoinInfo(from: dto),
            trendNFTInfo: trendNFTInfo(from: dto)
        )
    }
    
    private func trendCoinInfo(from dto: TrendInfoDTO) -> [TrendCoinInfo] {
        return dto.coins.prefix(14).map {
            TrendCoinInfo(
                rank: $0.item.score + 1,
                coinID: $0.item.id,
                coinSymbol: $0.item.symbol,
                coinName: $0.item.name,
                thumbImageURLString: $0.item.thumb,
                changePercent: changePercent(from: $0.item.data.priceChangePercentage24H.krw),
                changeState: changeState(from: $0.item.data.priceChangePercentage24H.krw)
            )
        }
    }
    
    private func trendNFTInfo(from dto: TrendInfoDTO) -> [TrendNFTInfo] {
        return dto.nfts.prefix(7).map {
            TrendNFTInfo(
                coinName: $0.name,
                floorPrice: $0.data.floorPrice,
                thumbImageURLString: $0.thumb,
                changePercent: changePercent(from: $0.floorPrice24HPercentageChange),
                changeState: changeState(from: $0.floorPrice24HPercentageChange)
            )
        }
    }
    
    private func changePercent(from value: Double) -> String {
        return NumberFormatterManager.shared.percentDidvidHundred(from: value)
    }
    
    private func changeState(from value: Double) -> ChangeState {
        if value == 0 {
            return .even
        } else if value > 0 {
            return .rise
        } else {
            return .fall
        }
    }
}
