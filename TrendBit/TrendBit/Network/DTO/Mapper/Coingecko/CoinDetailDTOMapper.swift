//
//  CoinDetailDTOMapper.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import Foundation

final class CoinDetailDTOMapper {
    
    func toEntity(from dto: CoinDetailDTO) -> CoinDetailEntity {
        
        return CoinDetailEntity(
            coinDetailInfo: coinDetailInfo(from: dto),
            coinDetailChartData: coinDetailChartData(from: dto),
            coinDetailTypeData: coinDetailTypeData(from: dto),
            coinDetailInvestmentData: coinDetailInvestmentData(from: dto)
        )
    }
    
    private func coinDetailInfo(from dto: CoinDetailDTO) -> CoinDetailInfo {
        return CoinDetailInfo(
            coinSymbol: dto.symbol,
            imageURLString: dto.image,
            favorite: false,
            currentPrice: currentPrice(from: dto.currentPrice),
            changePercent: changePercent(from: dto.priceChangePercentage24H),
            changeState: changeState(from: dto.priceChangePercentage24H),
            updateTime: DateFormatterManager.shared.detailUpdateTimeString(date: Date())
        )
    }
    
    private func coinDetailChartData(from dto: CoinDetailDTO) -> [CoinDetailChartData] {
        return dto.sparklineIn7D.price.map { CoinDetailChartData(changePrices: $0) }
    }
    
    private func coinDetailTypeData(from dto: CoinDetailDTO) -> CoinDetailTypeData {
        return CoinDetailTypeData(
            highPrice: currentPrice(from: dto.high24H),
            lowPrice: currentPrice(from: dto.low24H),
            allHighPrice: currentPrice(from: dto.ath),
            allHighDate: DateFormatterManager.shared.detailAllTheTimeString(dateString: dto.athDate),
            allLowPrice: currentPrice(from: dto.atl),
            allLowDate: DateFormatterManager.shared.detailAllTheTimeString(dateString: dto.atlDate)
        )
    }
    
    private func coinDetailInvestmentData(from dto: CoinDetailDTO) -> CoinDetailInvestmentData {
        return CoinDetailInvestmentData(
            capitalizationPrice: currentPrice(from: dto.marketCap),
            fdvPrice: currentPrice(from: dto.fullyDilutedValuation),
            volumePrice: currentPrice(from: dto.totalVolume)
        )
    }
    
    private func currentPrice(from value: Double?) -> String {
        guard let value else { return "가격정보 알 수 없음" }
        return "₩" + NumberFormatterManager.shared.pointNumberString(from: value)
    }
    
    private func changePercent(from value: Double?) -> String {
        guard let value else { return "퍼센트 정보 알 수 없음" }
        return NumberFormatterManager.shared.percentDidvidHundred(from: value)
    }
    
    private func changeState(from value: Double?) -> ChangeState {
        guard let value else { return .even }
        if value == 0 {
            return .even
        } else if value > 0 {
            return .rise
        } else {
            return .fall
        }
    }
}
