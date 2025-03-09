//
//  PoplarSearchSection.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RxDataSources

struct PoplarSearchSection {
    var items: [TrendCoinInfo]
}

extension PoplarSearchSection: SectionModelType {
    
    typealias Item = TrendCoinInfo
    
    init(original: PoplarSearchSection, items: [TrendCoinInfo]) {
        self = original
        self.items = items
    }
}
