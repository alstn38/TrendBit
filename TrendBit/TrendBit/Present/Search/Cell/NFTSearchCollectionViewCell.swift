//
//  NFTSearchCollectionViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit

final class NFTSearchCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
