//
//  SearchCoinDTOMapper.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

final class SearchCoinDTOMapper {
    
    func toEntity(from dto: SearchCoinDTO) -> [SearchCoinEntity] {
        
        return dto.coins.map {
            SearchCoinEntity(
                rank: "#\($0.marketCapRank)",
                coinID: $0.id,
                coinSymbol: $0.symbol,
                coinName: $0.name,
                thumbImageURLString: $0.thumb,
                favorite: false
            )
        }
    }
}
