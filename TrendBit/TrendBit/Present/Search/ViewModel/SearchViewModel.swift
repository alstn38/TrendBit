//
//  SearchViewModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import Foundation

final class SearchViewModel {
    
}

// MARK: - SearchViewType
extension SearchViewModel {
    
    enum SearchViewType: CaseIterable {
        case coin
        case nft
        case exchange
        
        var title: String {
            switch self {
            case .coin: return StringLiterals.Search.coinTitle
            case .nft: return StringLiterals.Search.nftTitle
            case .exchange: return StringLiterals.Search.exchangeTitle
            }
        }
    }
}
