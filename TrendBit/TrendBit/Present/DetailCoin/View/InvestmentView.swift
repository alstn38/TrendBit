//
//  InvestmentView.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class InvestmentView: UIView {
    
    private let titleLabel = UILabel()
    lazy var moreButton = UIButton(configuration: configureButtonConfiguration())
    private let infoBackgroundView = UIView()
    private let capitalizationTitleLabel = UILabel()
    private let capitalizationLabel = UILabel()
    private let fdvTitleLabel = UILabel()
    private let fdvLabel = UILabel()
    private let volumeTitleLabel = UILabel()
    private let volumeLabel = UILabel()
    
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
    
    func configureView(_ data: CoinDetailInvestmentData) {
        capitalizationLabel.text = data.capitalizationPrice
        fdvLabel.text = data.fdvPrice
        volumeLabel.text = data.volumePrice
    }
    
    private func configureView() {
        titleLabel.text = StringLiterals.DetailCoin.investmentTitle
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        infoBackgroundView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.1)
        infoBackgroundView.layer.cornerRadius = 20
        
        capitalizationTitleLabel.text = StringLiterals.DetailCoin.capitalizationTitle
        capitalizationTitleLabel.textColor = UIColor(resource: .trendBitGray)
        capitalizationTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        capitalizationLabel.textColor = UIColor(resource: .trendBitNavy)
        capitalizationLabel.font = .systemFont(ofSize: 14, weight: .bold)
        capitalizationLabel.numberOfLines = 1
        
        fdvTitleLabel.text = StringLiterals.DetailCoin.fdvTitle
        fdvTitleLabel.textColor = UIColor(resource: .trendBitGray)
        fdvTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        fdvLabel.textColor = UIColor(resource: .trendBitNavy)
        fdvLabel.font = .systemFont(ofSize: 14, weight: .bold)
        fdvLabel.numberOfLines = 1
        
        volumeTitleLabel.text = StringLiterals.DetailCoin.volumeTitle
        volumeTitleLabel.textColor = UIColor(resource: .trendBitGray)
        volumeTitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        volumeLabel.textColor = UIColor(resource: .trendBitNavy)
        volumeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        volumeLabel.numberOfLines = 1
    }
    
    private func configureHierarchy() {
        self.addSubviews(
            titleLabel,
            moreButton,
            infoBackgroundView,
            capitalizationTitleLabel,
            capitalizationLabel,
            fdvTitleLabel,
            fdvLabel,
            volumeTitleLabel,
            volumeLabel
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
            $0.bottom.equalTo(volumeLabel.snp.bottom).offset(18)
        }
        
        capitalizationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(infoBackgroundView).offset(18)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        capitalizationLabel.snp.makeConstraints {
            $0.top.equalTo(capitalizationTitleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(infoBackgroundView).offset(12)
        }
        
        fdvTitleLabel.snp.makeConstraints {
            $0.top.equalTo(capitalizationLabel.snp.bottom).offset(18)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        fdvLabel.snp.makeConstraints {
            $0.top.equalTo(fdvTitleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(infoBackgroundView).offset(12)
        }
        
        volumeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(fdvLabel.snp.bottom).offset(18)
            $0.leading.equalTo(infoBackgroundView).offset(12)
        }
        
        volumeLabel.snp.makeConstraints {
            $0.top.equalTo(volumeTitleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(infoBackgroundView).offset(12)
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
