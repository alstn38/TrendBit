//
//  PoplarSearchCollectionViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class PoplarSearchCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    private let rankLabel = UILabel()
    private let coinImageView = UIImageView()
    private let coinNameLabel = UILabel()
    private let coinSubNameLabel = UILabel()
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
        
        rankLabel.text = "1" // TODO: 서버 연결시 삭제
        rankLabel.textColor = UIColor(resource: .trendBitGray)
        rankLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        coinImageView.layer.cornerRadius = 13
        coinImageView.clipsToBounds = true
        coinImageView.backgroundColor = .cyan // TODO: 서버 연결시 삭제
        
        coinNameLabel.text = "TRUMP" // TODO: 서버 연결시 삭제
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 12, weight: .bold)
        coinNameLabel.numberOfLines = 1
        
        coinSubNameLabel.text = "Official Trump" // TODO: 서버 연결시 삭제
        coinSubNameLabel.textColor = UIColor(resource: .trendBitGray)
        coinSubNameLabel.font = .systemFont(ofSize: 9, weight: .regular)
        coinSubNameLabel.numberOfLines = 1
        
        arrowImageView.image = ImageAssets.arrowTriangleUpFill // TODO: 서버 연결시 삭제
        arrowImageView.contentMode = .scaleAspectFit
        
        variablePercentLabel.text = "36.18%" // TODO: 서버 연결시 삭제
        variablePercentLabel.textColor = UIColor(resource: .trendBitNavy) // TODO: 서버 연결시 삭제
        variablePercentLabel.font = .systemFont(ofSize: 9, weight: .bold)
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            rankLabel,
            coinImageView,
            coinNameLabel,
            coinSubNameLabel,
            arrowImageView,
            variablePercentLabel
        )
    }
    
    private func configureLayout() {
        rankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(rankLabel.snp.trailing).offset(12)
        }
        
        coinNameLabel.snp.makeConstraints {
            $0.top.equalTo(coinImageView)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(6)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-6)
        }
        
        coinSubNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(coinImageView)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(6)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-6)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(12)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(variablePercentLabel.snp.leading).offset(-2)
        }
        
        variablePercentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
