//
//  SearchCoinSection.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RxDataSources

struct SearchCoinSection {
    var items: [SearchCoinEntity]
}

extension SearchCoinSection: SectionModelType {
    
    typealias Item = SearchCoinEntity
    
    init(original: SearchCoinSection, items: [SearchCoinEntity]) {
        self = original
        self.items = items
    }
}
