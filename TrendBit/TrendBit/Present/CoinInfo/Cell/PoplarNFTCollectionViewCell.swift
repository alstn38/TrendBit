//
//  PoplarNFTCollectionViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import Kingfisher
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
    
    func configureCell(with data: TrendNFTInfo) {
        if let imageURL = URL(string: data.thumbImageURLString) {
            coinImageView.kf.setImage(with: imageURL)
        } else {
            coinImageView.image = ImageAssets.star
        }
        
        coinNameLabel.text = data.coinName
        coinPriceLabel.text = data.floorPrice
        variablePercentLabel.text = data.changePercent
        
        switch data.changeState {
        case .rise:
            arrowImageView.image = ImageAssets.arrowTriangleUpFill
            arrowImageView.tintColor = UIColor(resource: .trendBitRed)
            variablePercentLabel.textColor = UIColor(resource: .trendBitRed)
        case .fall:
            arrowImageView.image = ImageAssets.arrowTriangleDownFill
            arrowImageView.tintColor = UIColor(resource: .trendBitBlue)
            variablePercentLabel.textColor = UIColor(resource: .trendBitBlue)
        case .even:
            arrowImageView.image = nil
            arrowImageView.tintColor = UIColor(resource: .trendBitNavy)
            variablePercentLabel.textColor = UIColor(resource: .trendBitNavy)
        }
    }
    
    private func configureView() {
        self.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinImageView.layer.cornerRadius = 18
        coinImageView.clipsToBounds = true
        
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 9, weight: .bold)
        coinNameLabel.numberOfLines = 1
        coinNameLabel.textAlignment = .center
        
        coinPriceLabel.textColor = UIColor(resource: .trendBitGray)
        coinPriceLabel.font = .systemFont(ofSize: 9, weight: .regular)
        coinPriceLabel.numberOfLines = 1
        coinPriceLabel.textAlignment = .center
        
        variableStackView.axis = .horizontal
        variableStackView.spacing = 2
        variableStackView.alignment = .center
        variableStackView.distribution = .equalSpacing
        
        arrowImageView.contentMode = .scaleAspectFit
        
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
            $0.horizontalEdges.equalToSuperview().inset(4)
        }
        
        coinPriceLabel.snp.makeConstraints {
            $0.top.equalTo(coinNameLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(4)
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
