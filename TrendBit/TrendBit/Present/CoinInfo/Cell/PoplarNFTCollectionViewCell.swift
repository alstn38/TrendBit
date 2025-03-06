//
//  PoplarNFTCollectionViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class PoplarNFTCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    private let coinImageView = UIImageView()
    private let coinNameLabel = UILabel()
    private let coinPriceLabel = UILabel()
    private let variableStackView = UIStackView()
    private let arrowImageView = UIImageView()
    private let variablePercentLabel = UILabel()
    
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
        self.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinImageView.layer.cornerRadius = 18
        coinImageView.clipsToBounds = true
        coinImageView.backgroundColor = .cyan // TODO: 서버 연결시 삭제
        
        coinNameLabel.text = "TRUMP" // TODO: 서버 연결시 삭제
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 9, weight: .bold)
        coinNameLabel.numberOfLines = 1
        
        coinPriceLabel.text = "0.66 ETH" // TODO: 서버 연결시 삭제
        coinPriceLabel.textColor = UIColor(resource: .trendBitGray)
        coinPriceLabel.font = .systemFont(ofSize: 9, weight: .regular)
        coinPriceLabel.numberOfLines = 1
        
        variableStackView.axis = .horizontal
        variableStackView.spacing = 2
        variableStackView.alignment = .center
        variableStackView.distribution = .equalSpacing
        
        arrowImageView.image = ImageAssets.arrowTriangleUpFill // TODO: 서버 연결시 삭제
        arrowImageView.contentMode = .scaleAspectFit
        
        variablePercentLabel.text = "36.18%" // TODO: 서버 연결시 삭제
        variablePercentLabel.textColor = UIColor(resource: .trendBitNavy) // TODO: 서버 연결시 삭제
        variablePercentLabel.font = .systemFont(ofSize: 9, weight: .bold)
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            coinImageView,
            coinNameLabel,
            coinPriceLabel,
            variableStackView
        )
        
        variableStackView.addArrangedSubviews(
            arrowImageView,
            variablePercentLabel
        )
    }
    
    private func configureLayout() {
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(72)
            $0.top.centerX.equalToSuperview()
        }
        
        coinNameLabel.snp.makeConstraints {
            $0.top.equalTo(coinImageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        coinPriceLabel.snp.makeConstraints {
            $0.top.equalTo(coinNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        variableStackView.snp.makeConstraints {
            $0.top.equalTo(coinPriceLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(12)
        }
    }
}
