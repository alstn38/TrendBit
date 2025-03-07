//
//  DetailCoinViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SwiftUI
import SnapKit

final class DetailCoinViewController: UIViewController {
    
    private let popButton = UIButton()
    private let titleStackView = UIStackView()
    private let coinImageView = UIImageView()
    private let coinNameLabel = UILabel()
    private let favoriteButton = UIButton()
    private let lineView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let priceLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let percentageLabel = UILabel()
    private let updateTimeLabel = UILabel()
    private let coinCartView = UIHostingController(rootView: CoinChartView())
    private let typeInfoView = TypeInfoView()
    private let investmentView = InvestmentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        
        popButton.setImage(ImageAssets.arrowLeft, for: .normal)
        popButton.tintColor = UIColor(resource: .trendBitNavy)
        
        titleStackView.axis = .horizontal
        titleStackView.spacing = 4
        titleStackView.distribution = .equalSpacing
        
        coinImageView.image = UIImage(systemName: "star") // TODO: 서버 연결시 제거
        coinImageView.contentMode = .scaleAspectFit
        
        coinNameLabel.text = "BTC" // TODO: 서버 연결시 제거
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        favoriteButton.setImage(ImageAssets.star, for: .normal) // TODO: 서버 연결시 제거
        favoriteButton.contentMode = .scaleAspectFit
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3)
        
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        priceLabel.text = "₩140,375,904" // TODO: 서버 연결시 제거
        priceLabel.textColor = UIColor(resource: .trendBitNavy)
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        priceLabel.numberOfLines = 1
        
        arrowImageView.image = ImageAssets.arrowTriangleDownFill // TODO: 서버 연결시 제거
        arrowImageView.contentMode = .scaleAspectFit
        
        percentageLabel.text = "0.98%" // TODO: 서버 연결시 제거
        percentageLabel.textColor = UIColor(resource: .trendBitNavy) // TODO: 서버 연결시 제거
        percentageLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        updateTimeLabel.text = "2/15 18:00:45 업데이트" // TODO: 서버 연결시 제거
        updateTimeLabel.textColor = UIColor(resource: .trendBitNavy).withAlphaComponent(0.3)
        updateTimeLabel.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    private func configureHierarchy() {
        addChild(coinCartView)
        
        view.addSubviews(
            popButton,
            titleStackView,
            favoriteButton,
            lineView,
            scrollView
        )
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            priceLabel,
            arrowImageView,
            percentageLabel,
            updateTimeLabel,
            coinCartView.view,
            typeInfoView,
            investmentView
        )
        
        titleStackView.addArrangedSubviews(
            coinImageView,
            coinNameLabel
        )
        
        coinCartView.didMove(toParent: self)
    }
    
    private func configureLayout() {
        popButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(12)
            $0.size.equalTo(24)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(popButton)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.trailing.equalToSuperview().inset(12)
            $0.size.equalTo(24)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(popButton.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.horizontalEdges.equalToSuperview().offset(12)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(12)
            $0.top.equalTo(priceLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(12)
        }
        
        percentageLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(4)
            $0.centerY.equalTo(arrowImageView)
        }
        
        coinCartView.view.snp.makeConstraints {
            $0.top.equalTo(arrowImageView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(250)
        }
        
        updateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(coinCartView.view.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(12)
        }
        
        typeInfoView.snp.makeConstraints {
            $0.top.equalTo(updateTimeLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        investmentView.snp.makeConstraints {
            $0.top.equalTo(typeInfoView.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(260)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
