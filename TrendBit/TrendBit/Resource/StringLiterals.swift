//
//  StringLiterals.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import Foundation

enum StringLiterals {
    
    enum NavigationItem {
        static let backButtonTitle: String = ""
    }
    
    enum TapBar {
        static let exchangeTitle: String = "거래소"
        static let coinInfoTitle: String = "코인정보"
        static let portfolioTitle: String = "포트폴리오"
    }
    
    enum Exchange {
        static let title: String = "거래소"
        static let coinTitle: String = "코인"
        static let currentPriceViewButtonTitle: String = "현재가"
        static let previousDayViewButtonTitle: String = "전일대비"
        static let transactionAmountViewButtonTitle: String = "거래대금"
    }
    
    enum CoinInfo {
        static let title: String = "가상자산 / 심볼 검색"
        static let searchTextFieldPlaceholder: String = "검색어를 입력해주세요."
        static let popularSearchTitle: String = "인기 검색어"
        static let popularNFTTitle: String = "인기 NFT"
    }
}
