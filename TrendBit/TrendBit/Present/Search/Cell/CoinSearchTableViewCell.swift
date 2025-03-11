//
//  CoinSearchTableViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa
import SnapKit

final class CoinSearchTableViewCell: UITableViewCell, ReusableViewProtocol {
    
    var disposeBag = DisposeBag()
    
    private let coinImageView = UIImageView()
    private let coinNameLabel = UILabel()
    private let coinSubNameLabel = UILabel()
    private let hashTagBackgroundView = UIView()
    private let hashTagLabel = UILabel()
    let favoriteButton = UIButton()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    func configureCell(with data: SearchCoinEntity) {
        if let imageURL = URL(string: data.thumbImageURLString) {
            coinImageView.kf.setImage(with: imageURL)
        } else {
            coinImageView.image = ImageAssets.star
        }
        
        coinNameLabel.text = data.coinSymbol
        coinSubNameLabel.text = data.coinName
        hashTagLabel.text = data.rank
        
        let favoriteImage = data.favorite ? ImageAssets.starFill : ImageAssets.star
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinImageView.layer.cornerRadius = 18
        coinImageView.clipsToBounds = true
        
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        coinNameLabel.numberOfLines = 1
        
        coinSubNameLabel.textColor = UIColor(resource: .trendBitGray)
        coinSubNameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        coinSubNameLabel.numberOfLines = 1
        
        hashTagBackgroundView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3)
        hashTagBackgroundView.layer.cornerRadius = 5
        hashTagBackgroundView.clipsToBounds = true
        
        hashTagLabel.textColor = UIColor(resource: .trendBitGray)
        hashTagLabel.font = .systemFont(ofSize: 9, weight: .bold)
        hashTagLabel.numberOfLines = 1
        
        favoriteButton.tintColor = UIColor(resource: .trendBitNavy)
    }
    
    private func configureHierarchy() {
        contentView.addSubviews(
            coinImageView,
            coinNameLabel,
            coinSubNameLabel,
            hashTagBackgroundView,
            hashTagLabel,
            favoriteButton
        )
    }
    
    private func configureLayout() {
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        coinNameLabel.snp.makeConstraints {
            $0.top.equalTo(coinImageView)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(18)
        }
        
        coinSubNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(coinImageView)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(18)
        }
        
        hashTagBackgroundView.snp.makeConstraints {
            $0.edges.equalTo(hashTagLabel).inset(-4)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.centerY.equalTo(coinNameLabel)
            $0.leading.equalTo(coinNameLabel.snp.trailing).offset(12)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
