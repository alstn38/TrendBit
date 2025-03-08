//
//  ExchangeSection.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RxDataSources

struct ExchangeSection {
    var items: [ExchangeDataEntity]
}

extension ExchangeSection: SectionModelType {
    
    typealias Item = ExchangeDataEntity
    
    init(original: ExchangeSection, items: [ExchangeDataEntity]) {
        self = original
        self.items = items
    }
}
