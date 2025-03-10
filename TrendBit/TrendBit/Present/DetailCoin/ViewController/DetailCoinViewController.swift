//
//  DetailCoinViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import Kingfisher
import RxDataSources
import RxSwift
import RxCocoa
import SwiftUI
import SnapKit

final class DetailCoinViewController: UIViewController {
    
    private let viewModel: DetailCoinViewModel
    private let disposeBag = DisposeBag()
    
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
    
    init(viewModel: DetailCoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let input = DetailCoinViewModel.Input(
            viewDidLoad: Observable.just(()),
            popButtonDidTap: popButton.rx.tap.asObservable(),
            favoriteButtonDidTap: favoriteButton.rx.tap.asObservable(),
            moreTypeInfoButtonDidTap: typeInfoView.moreButton.rx.tap.asObservable(),
            investmentInfoButtonDidTap: investmentView.moreButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.isFavoriteCoin
            .map { $0 ? ImageAssets.starFill : ImageAssets.star }
            .drive(favoriteButton.rx.image())
            .disposed(by: disposeBag)
        
        output.detailCoinData
            .drive(with: self) { owner, detailCoinData in
                owner.configureCoinDetailInfo(detailCoinData.coinDetailInfo)
                owner.configureCoinDetailChartData(detailCoinData.coinDetailChartData)
                owner.typeInfoView.configureView(detailCoinData.coinDetailTypeData)
                owner.investmentView.configureView(detailCoinData.coinDetailInvestmentData)
            }
            .disposed(by: disposeBag)
        
        output.moveToOtherView
            .drive(with: self) { owner, viewType in
                switch viewType {
                case .pop:
                    owner.navigationController?.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.loadingIndicator
            .drive { isAnimate in
                if isAnimate {
                    LoadingIndicator.showLoading()
                } else {
                    LoadingIndicator.hideLoading()
                }
            }
            .disposed(by: disposeBag)
        
        output.presentError
            .drive(with: self) { owner, value in
                let (title, message) = value
                owner.presentAlert(title: title, message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        
        popButton.setImage(ImageAssets.arrowLeft, for: .normal)
        popButton.tintColor = UIColor(resource: .trendBitNavy)
        
        titleStackView.axis = .horizontal
        titleStackView.spacing = 4
        titleStackView.distribution = .equalSpacing
        
        coinImageView.contentMode = .scaleAspectFit
        coinImageView.layer.cornerRadius = 12
        coinImageView.clipsToBounds = true
        
        coinNameLabel.textColor = UIColor(resource: .trendBitNavy)
        coinNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        favoriteButton.contentMode = .scaleAspectFit
        favoriteButton.tintColor = UIColor(resource: .trendBitNavy)
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3)
        
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        priceLabel.textColor = UIColor(resource: .trendBitNavy)
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        priceLabel.numberOfLines = 1
        
        arrowImageView.contentMode = .scaleAspectFit
        
        percentageLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
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
        
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(24)
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
    
    private func configureCoinDetailInfo(_ data: CoinDetailInfo) {
        coinImageView.kf.setImage(with: URL(string: data.imageURLString))
        
        coinNameLabel.text = data.coinSymbol
        priceLabel.text = data.currentPrice
        percentageLabel.text = data.changePercent
        updateTimeLabel.text = data.updateTime
        
        switch data.changeState {
        case .rise:
            arrowImageView.image = ImageAssets.arrowTriangleUpFill
            arrowImageView.tintColor = UIColor(resource: .trendBitRed)
            percentageLabel.textColor = UIColor(resource: .trendBitRed)
        case .fall:
            arrowImageView.image = ImageAssets.arrowTriangleDownFill
            arrowImageView.tintColor = UIColor(resource: .trendBitBlue)
            percentageLabel.textColor = UIColor(resource: .trendBitBlue)
        case .even:
            arrowImageView.image = nil
            arrowImageView.tintColor = UIColor(resource: .trendBitNavy)
            percentageLabel.textColor = UIColor(resource: .trendBitNavy)
        }
    }
    
    private func configureCoinDetailChartData(_ data: [CoinDetailChartData]) {
        coinCartView.rootView.configureChart(data)
    }
}
