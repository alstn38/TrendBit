//
//  SearchCoinEntity.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

struct SearchCoinEntity {
    let rank: String
    let coinID: String
    let coinSymbol: String
    let coinName: String
    let thumbImageURLString: String
    let favorite: Bool
}

extension SearchCoinEntity {
    
    func setFavoriteState(_ isFavorite: Bool) -> SearchCoinEntity {
        return SearchCoinEntity(
            rank: self.rank,
            coinID: self.coinID,
            coinSymbol: self.coinSymbol,
            coinName: self.coinName,
            thumbImageURLString: self.thumbImageURLString,
            favorite: isFavorite
        )
    }
}
