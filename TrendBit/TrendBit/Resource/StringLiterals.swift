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
    
    enum Alert {
        static let guideTitle: String = "안내"
        static let networkError: String = "네트워크 에러"
        static let localDataError: String = "로컬 데이터 에러"
        static let confirm: String = "확인"
        static let connectError: String = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        static let retry: String = "다시 시도하기"
    }
    
    enum Toast {
        static let notReady: String = "준비 중입니다"
        static let addFavoriteCoin: String = "이 즐겨찾기되었습니다."
        static let deleteFavoriteCoin: String = "이 즐겨찾기에서 제거되었습니다."
        static let connectError: String = "네트워크 통신이 원활하지 않습니다."
        static let noResult: String = "검색 결과가 없습니다."
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
    
    enum Search {
        static let searchTextFieldPlaceholder: String = "검색어를 입력해주세요."
        static let coinTitle: String = "코인"
        static let nftTitle: String = "NFT"
        static let exchangeTitle: String = "거래소"
    }
    
    enum DetailCoin {
        static let typeInfoTitle: String = "종목정보"
        static let moreButtonTitle: String = "더보기"
        static let highPriceTitle: String = "24시간 고가"
        static let lowPriceTitle: String = "24시간 저가"
        static let allHighPriceTitle: String = "역대 최고가"
        static let allLowPriceTitle: String = "역대 최저가"
        static let capitalizationTitle: String = "시가총액"
        static let fdvTitle: String = "완전 희석 가치(FDV)"
        static let volumeTitle: String = "총 거래량"
    }
}
