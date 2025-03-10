//
//  CoinDetailEntity.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import Foundation

struct CoinDetailEntity {
    let coinDetailInfo: CoinDetailInfo
    let coinDetailChartData: [CoinDetailChartData]
    let coinDetailTypeData: CoinDetailTypeData
    let coinDetailInvestmentData: CoinDetailInvestmentData
}

struct CoinDetailInfo {
    let coinSymbol: String
    let imageURLString: String
    let favorite: Bool
    let currentPrice: String
    let changePercent: String
    let changeState: ChangeState
    let updateTime: String
}

struct CoinDetailChartData: Identifiable {
    let id = UUID()
    let changePrices: Double
}

struct CoinDetailTypeData {
    let highPrice: String
    let lowPrice: String
    let allHighPrice: String
    let allHighDate: String
    let allLowPrice: String
    let allLowDate: String
}

struct CoinDetailInvestmentData {
    let capitalizationPrice: String
    let fdvPrice: String
    let volumePrice: String
}

extension CoinDetailEntity {
    
    func setFavoriteState(_ isFavorite: Bool) -> CoinDetailEntity {
        let coinDetailInfo = CoinDetailInfo(
            coinSymbol: self.coinDetailInfo.coinSymbol,
            imageURLString: self.coinDetailInfo.imageURLString,
            favorite: isFavorite,
            currentPrice: self.coinDetailInfo.currentPrice,
            changePercent: self.coinDetailInfo.changePercent,
            changeState: self.coinDetailInfo.changeState,
            updateTime: self.coinDetailInfo.updateTime
        )
        
        return CoinDetailEntity(
            coinDetailInfo: coinDetailInfo,
            coinDetailChartData: self.coinDetailChartData,
            coinDetailTypeData: self.coinDetailTypeData,
            coinDetailInvestmentData: self.coinDetailInvestmentData
        )
    }
    
    static func dummy() -> CoinDetailEntity {
        return CoinDetailEntity(
            coinDetailInfo: CoinDetailInfo(
                coinSymbol: "",
                imageURLString: "",
                favorite: false,
                currentPrice: "",
                changePercent: "",
                changeState: .even,
                updateTime: ""
            ),
            coinDetailChartData: [],
            coinDetailTypeData: CoinDetailTypeData(
                highPrice: "",
                lowPrice: "",
                allHighPrice: "",
                allHighDate: "",
                allLowPrice: "",
                allLowDate: ""
            ),
            coinDetailInvestmentData: CoinDetailInvestmentData(
                capitalizationPrice: "",
                fdvPrice: "",
                volumePrice: ""
            )
        )
    }
}
