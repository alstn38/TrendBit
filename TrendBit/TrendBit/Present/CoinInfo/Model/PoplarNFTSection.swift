//
//  PoplarNFTSection.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RxDataSources

struct PoplarNFTSection {
    var items: [TrendNFTInfo]
}

extension PoplarNFTSection: SectionModelType {
    
    typealias Item = TrendNFTInfo
    
    init(original: PoplarNFTSection, items: [TrendNFTInfo]) {
        self = original
        self.items = items
    }
}
