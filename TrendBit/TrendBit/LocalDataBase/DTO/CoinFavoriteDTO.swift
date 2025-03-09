//
//  CoinFavoriteDTO.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RealmSwift

final class CoinFavoriteDTO: Object {
    @Persisted(primaryKey: true) var coinID: String
    
    convenience init(coinID: String) {
        self.init()
        self.coinID = coinID
    }
}
