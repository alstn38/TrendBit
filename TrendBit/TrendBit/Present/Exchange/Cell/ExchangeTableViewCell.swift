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
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinNameLabel.text = "기본코인" // TODO: 서버 연결 시 삭제
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        coinNameLabel.numberOfLines = 1
        
        currentPriceLabel.text = "4,025,000" // TODO: 서버 연결 시 삭제
        currentPriceLabel.textColor = UIColor(resource: .trendBitGray)
        currentPriceLabel.font = .systemFont(ofSize: 12, weight: .regular)
        currentPriceLabel.numberOfLines = 1
        
        previousDayPercentLabel.text = "-3.72%" // TODO: 서버 연결 시 삭제
        previousDayPercentLabel.font = .systemFont(ofSize: 12, weight: .regular)
        previousDayPercentLabel.numberOfLines = 1
        
        
        previousDayAmountLabel.text = "-154" // TODO: 서버 연결 시 삭제
        previousDayAmountLabel.font = .systemFont(ofSize: 9, weight: .regular)
        previousDayAmountLabel.numberOfLines = 1
        
        transactionAmount.text = "180,826백만" // TODO: 서버 연결 시 삭제
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
