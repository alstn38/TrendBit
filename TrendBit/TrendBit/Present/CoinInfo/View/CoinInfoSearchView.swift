//
//  CoinInfoSearchView.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import SnapKit

final class CoinInfoSearchView: UIView {
    
    private let searchImageView = UIImageView()
    let searchTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3).cgColor
        
        searchImageView.image = ImageAssets.magnifyingGlass
        searchImageView.tintColor = UIColor(resource: .trendBitGray)
        searchImageView.contentMode = .scaleAspectFill
        
        searchTextField.placeholder = StringLiterals.CoinInfo.searchTextFieldPlaceholder
        searchTextField.textColor = UIColor(resource: .trendBitNavy)
        searchTextField.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    private func configureHierarchy() {
        self.addSubviews(
            searchImageView,
            searchTextField
        )
    }
    
    private func configureLayout() {
        searchImageView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(6)
        }
    }
}
