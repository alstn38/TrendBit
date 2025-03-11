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
                rank: rank(from: $0.marketCapRank),
                coinID: $0.id,
                coinSymbol: $0.symbol,
                coinName: $0.name,
                thumbImageURLString: $0.thumb,
                favorite: false
            )
        }
    }
    
    private func rank(from rank: Int?) -> String {
        guard let rank else { return "랭킹 정보 없음" }
        return "#\(rank)"
    }
}
