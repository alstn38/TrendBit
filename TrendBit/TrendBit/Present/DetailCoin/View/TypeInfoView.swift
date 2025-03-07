//
//  TypeInfoView.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class TypeInfoView: UIView {
    
    private let titleLabel = UILabel()
    private lazy var moreButton = UIButton(configuration: configureButtonConfiguration())
    private let infoBackgroundView = UIView()
    private let highPriceTitleLabel = UILabel()
    private let highPriceLabel = UILabel()
    private let lowPriceTitleLabel = UILabel()
    private let lowPriceLabel = UILabel()
    private let allHighPriceTitleLabel = UILabel()
    private let allHighPriceLabel = UILabel()
    private let allHighDateLabel = UILabel()
    private let allLowPriceTitleLabel = UILabel()
    private let allLowPriceLabel = UILabel()
    private let allLowDateLabel = UILabel()
    
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
        titleLabel.text = StringLiterals.DetailCoin.typeInfoTitle
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        infoBackgroundView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.1)
        infoBackgroundView.layer.cornerRadius = 20
        
        highPriceTitleLabel.text = StringLiterals.DetailCoin.highPriceTitle
        highPriceTitleLabel.textColor = UIColor(resource: .trendBitGray)
        highPriceTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        highPriceLabel.text = "₩142,060,809" // TODO: 서버 연결시 삭제
        highPriceLabel.textColor = UIColor(resource: .trendBitNavy)
        highPriceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        highPriceLabel.numberOfLines = 1
        
        lowPriceTitleLabel.text = StringLiterals.DetailCoin.lowPriceTitle
        lowPriceTitleLabel.textColor = UIColor(resource: .trendBitGray)
        lowPriceTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        lowPriceLabel.text = "₩142,060,809" // TODO: 서버 연결시 삭제
        lowPriceLabel.textColor = UIColor(resource: .trendBitNavy)
        lowPriceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        lowPriceLabel.numberOfLines = 1
        
        allHighPriceTitleLabel.text = StringLiterals.DetailCoin.allHighPriceTitle
        allHighPriceTitleLabel.textColor = UIColor(resource: .trendBitGray)
        allHighPriceTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        allHighPriceLabel.text = "₩142,060,809" // TODO: 서버 연결시 삭제
        allHighPriceLabel.textColor = UIColor(resource: .trendBitNavy)
        allHighPriceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        allHighPriceLabel.numberOfLines = 1
        
        allHighDateLabel.text = "25년 1월 20일" // TODO: 서버 연결시 삭제
        allHighDateLabel.textColor = UIColor(resource: .trendBitGray)
        allHighDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        allLowPriceTitleLabel.text = StringLiterals.DetailCoin.allLowPriceTitle
        allLowPriceTitleLabel.textColor = UIColor(resource: .trendBitGray)
        allLowPriceTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        allLowPriceLabel.text = "₩142,060,809" // TODO: 서버 연결시 삭제
        allLowPriceLabel.textColor = UIColor(resource: .trendBitNavy)
        allLowPriceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        allLowPriceLabel.numberOfLines = 1
        
        allLowDateLabel.text = "25년 1월 20일" // TODO: 서버 연결시 삭제
        allLowDateLabel.textColor = UIColor(resource: .trendBitGray)
        allLowDateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    private func configureHierarchy() {
        self.addSubviews(
            titleLabel,
            moreButton,
            infoBackgroundView,
            highPriceTitleLabel,
            highPriceLabel,
            lowPriceTitleLabel,
            lowPriceLabel,
            allHighPriceTitleLabel,
            allHighPriceLabel,
            allHighDateLabel,
            allLowPriceTitleLabel,
            allLowPriceLabel,
            allLowDateLabel
        )
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        
        infoBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.bottom.equalTo(allLowDateLabel.snp.bottom).offset(18)
        }
        
        highPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(18)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        highPriceLabel.snp.makeConstraints {
            $0.top.equalTo(highPriceTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(infoBackgroundView).offset(12)
            $0.trailing.equalTo(lowPriceTitleLabel.snp.leading).offset(-12)
        }
        
        lowPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(18)
            $0.leading.equalTo(infoBackgroundView.snp.centerX).offset(12)
        }
        
        lowPriceLabel.snp.makeConstraints {
            $0.top.equalTo(lowPriceTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(infoBackgroundView.snp.centerX).offset(12)
            $0.trailing.equalTo(infoBackgroundView).inset(12)
        }
        
        allHighPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(highPriceLabel.snp.bottom).offset(18)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        allHighPriceLabel.snp.makeConstraints {
            $0.top.equalTo(allHighPriceTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(infoBackgroundView).offset(12)
            $0.trailing.equalTo(allLowPriceLabel.snp.leading).offset(-12)
        }
        
        allHighDateLabel.snp.makeConstraints {
            $0.top.equalTo(allHighPriceLabel.snp.bottom).offset(4)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        allLowPriceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lowPriceLabel.snp.bottom).offset(18)
            $0.leading.equalTo(infoBackgroundView.snp.centerX).offset(12)
        }
        
        allLowPriceLabel.snp.makeConstraints {
            $0.top.equalTo(allLowPriceTitleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(infoBackgroundView.snp.centerX).offset(12)
            $0.trailing.equalTo(infoBackgroundView).inset(12)
        }
        
        allLowDateLabel.snp.makeConstraints {
            $0.top.equalTo(allLowPriceLabel.snp.bottom).offset(4)
            $0.leading.equalTo(infoBackgroundView.snp.centerX).offset(12)
        }
    }
    
    private func configureButtonConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        configuration.attributedTitle = AttributedString(StringLiterals.DetailCoin.moreButtonTitle, attributes: titleContainer)
        configuration.image = ImageAssets.chevronRight
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        configuration.imagePadding = 6
        configuration.baseForegroundColor = UIColor(resource: .trendBitGray)
        configuration.imagePlacement = .trailing
        
        return configuration
    }
}
