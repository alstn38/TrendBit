//
//  CoinSearchCollectionViewCell.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class CoinSearchCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    
    private let coinSearchTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureHierarchy()
        configureLayout()
        coinSearchTableView.register(CoinSearchTableViewCell.self, forCellReuseIdentifier: CoinSearchTableViewCell.identifier) // TODO: 이후 삭제
        coinSearchTableView.delegate = self // TODO: 이후 삭제
        coinSearchTableView.dataSource = self // TODO: 이후 삭제
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        coinSearchTableView.backgroundColor = UIColor(resource: .trendBitWhite)
        coinSearchTableView.rowHeight = 60
        coinSearchTableView.showsVerticalScrollIndicator = false
    }
    
    private func configureHierarchy() {
        contentView.addSubview(coinSearchTableView)
    }
    
    private func configureLayout() {
        coinSearchTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// TODO: 이후 삭제
extension CoinSearchCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoinSearchTableViewCell.identifier,
            for: indexPath
        ) as? CoinSearchTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
