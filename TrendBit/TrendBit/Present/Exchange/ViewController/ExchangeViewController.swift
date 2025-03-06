//
//  ExchangeViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import SnapKit

final class ExchangeViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let lineView = UIView()
    private let filterView = UIView()
    private let coinTitleLabel = UILabel()
    private let currentPriceViewButton = FilterViewButton(title: StringLiterals.Exchange.currentPriceViewButtonTitle)
    private let previousDayViewButton = FilterViewButton(title: StringLiterals.Exchange.previousDayViewButtonTitle)
    private let transactionAmountViewButton = FilterViewButton(title: StringLiterals.Exchange.transactionAmountViewButtonTitle)
    private let exchangeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        
        exchangeTableView.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.identifier) // TODO: 삭제
        exchangeTableView.delegate = self // TODO: 삭제
        exchangeTableView.dataSource = self  // TODO: 삭제
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        
        titleLabel.text = StringLiterals.Exchange.title
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.5)
        
        filterView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3)
        
        coinTitleLabel.text = StringLiterals.Exchange.coinTitle
        coinTitleLabel.textColor = UIColor(resource: .trendBitNavy)
        coinTitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        exchangeTableView.backgroundColor = UIColor(resource: .trendBitWhite)
        exchangeTableView.showsVerticalScrollIndicator = false
        exchangeTableView.rowHeight = 50
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            titleLabel,
            lineView,
            filterView,
            coinTitleLabel,
            currentPriceViewButton,
            previousDayViewButton,
            transactionAmountViewButton,
            exchangeTableView
        )
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(12)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        filterView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        coinTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(12)
            $0.centerY.equalTo(filterView)
        }
        
        currentPriceViewButton.snp.makeConstraints {
            $0.centerY.equalTo(filterView)
            $0.trailing.equalTo(previousDayViewButton.snp.leading).offset(-36)
        }
        
        previousDayViewButton.snp.makeConstraints {
            $0.centerY.equalTo(filterView)
            $0.trailing.equalTo(transactionAmountViewButton.snp.leading).offset(-48)
        }
        
        transactionAmountViewButton.snp.makeConstraints {
            $0.centerY.equalTo(filterView)
            $0.trailing.equalTo(filterView).offset(-12)
        }
        
        exchangeTableView.snp.makeConstraints {
            $0.top.equalTo(filterView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// TODO: 삭제
extension ExchangeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeTableViewCell.identifier,
            for: indexPath
        ) as? ExchangeTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
