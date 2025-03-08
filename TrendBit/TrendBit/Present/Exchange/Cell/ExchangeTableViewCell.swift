//
//  ExchangeTableViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import SnapKit

final class ExchangeTableViewCell: UITableViewCell, ReusableViewProtocol {
    
    private let coinNameLabel = UILabel()
    private let currentPriceLabel = UILabel()
    private let previousDayPercentLabel = UILabel()
    private let previousDayAmountLabel = UILabel()
    private let transactionAmount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with data: ExchangeDataEntity) {
        coinNameLabel.text = data.coinName
        currentPriceLabel.text = data.currentPrice
        previousDayPercentLabel.text = data.changePercent
        previousDayAmountLabel.text = data.changePrice
        transactionAmount.text = data.transactionAmount
        
        switch data.changeState {
        case .rise:
            previousDayPercentLabel.textColor = UIColor(resource: .trendBitRed)
            previousDayAmountLabel.textColor = UIColor(resource: .trendBitRed)
        case .fall:
            previousDayPercentLabel.textColor = UIColor(resource: .trendBitBlue)
            previousDayAmountLabel.textColor = UIColor(resource: .trendBitBlue)
        case .even:
            previousDayPercentLabel.textColor = UIColor(resource: .trendBitGray)
            previousDayAmountLabel.textColor = UIColor(resource: .trendBitGray)
        }
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        coinNameLabel.numberOfLines = 1
        
        currentPriceLabel.textColor = UIColor(resource: .trendBitGray)
        currentPriceLabel.font = .systemFont(ofSize: 12, weight: .regular)
        currentPriceLabel.numberOfLines = 1
        
        previousDayPercentLabel.font = .systemFont(ofSize: 12, weight: .regular)
        previousDayPercentLabel.numberOfLines = 1
        
        previousDayAmountLabel.font = .systemFont(ofSize: 9, weight: .regular)
        previousDayAmountLabel.numberOfLines = 1
        
        transactionAmount.textColor = UIColor(resource: .trendBitGray)
        transactionAmount.font = .systemFont(ofSize: 12, weight: .regular)
        transactionAmount.numberOfLines = 1
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            coinNameLabel,
            currentPriceLabel,
            previousDayPercentLabel,
            previousDayAmountLabel,
            transactionAmount
        )
    }
    
    private func configureLayout() {
        coinNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-6)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(currentPriceLabel.snp.leading).offset(4)
        }
        
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-6)
            $0.trailing.equalToSuperview().offset(-195)
        }
        
        previousDayPercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-6)
            $0.trailing.equalToSuperview().offset(-110)
        }
        
        previousDayAmountLabel.snp.makeConstraints {
            $0.top.equalTo(previousDayPercentLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(previousDayPercentLabel)
        }
        
        transactionAmount.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-6)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
}
