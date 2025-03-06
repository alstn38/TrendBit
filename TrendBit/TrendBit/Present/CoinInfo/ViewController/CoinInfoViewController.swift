//
//  CoinInfoViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import SnapKit

final class CoinInfoViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let lineView = UIView()
    private let searchView = CoinInfoSearchView()
    private let popularSearchTitleLabel = UILabel()
    private let updateTimeLabel = UILabel()
    private lazy var poplarSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: poplarSearchCollectionFlowLayout())
    private let popularNFTTitleLabel = UILabel()
    private lazy var poplarNFTCollectionView = UICollectionView(frame: .zero, collectionViewLayout: poplarNFTCollectionFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        
        poplarSearchCollectionView.register(PoplarSearchCollectionViewCell.self, forCellWithReuseIdentifier: PoplarSearchCollectionViewCell.identifier) // TODO: 이후 삭제
        poplarSearchCollectionView.delegate = self // TODO: 이후 삭제
        poplarSearchCollectionView.dataSource = self // TODO: 이후 삭제
        poplarNFTCollectionView.register(PoplarNFTCollectionViewCell.self, forCellWithReuseIdentifier: PoplarNFTCollectionViewCell.identifier) // TODO: 이후 삭제
        poplarNFTCollectionView.delegate = self // TODO: 이후 삭제
        poplarNFTCollectionView.dataSource = self // TODO: 이후 삭제
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        
        titleLabel.text = StringLiterals.CoinInfo.title
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.5)
        
        popularSearchTitleLabel.text = StringLiterals.CoinInfo.popularSearchTitle
        popularSearchTitleLabel.textColor = UIColor(resource: .trendBitNavy)
        popularSearchTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        updateTimeLabel.text = "02.16 00:30 기준" // TODO: 서버 연결 시 삭제
        updateTimeLabel.textColor = UIColor(resource: .trendBitGray)
        updateTimeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        poplarSearchCollectionView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        popularNFTTitleLabel.text = StringLiterals.CoinInfo.popularNFTTitle
        popularNFTTitleLabel.textColor = UIColor(resource: .trendBitNavy)
        popularNFTTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        poplarNFTCollectionView.backgroundColor = UIColor(resource: .trendBitWhite)
        poplarNFTCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            titleLabel,
            lineView,
            searchView,
            popularSearchTitleLabel,
            updateTimeLabel,
            poplarSearchCollectionView,
            popularNFTTitleLabel,
            poplarNFTCollectionView
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
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(50)
        }
        
        popularSearchTitleLabel.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(12)
        }
        
        updateTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(popularSearchTitleLabel)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        poplarSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularSearchTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(350)
        }
        
        popularNFTTitleLabel.snp.makeConstraints {
            $0.top.equalTo(poplarSearchCollectionView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(12)
        }
        
        poplarNFTCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularNFTTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(130)
        }
    }
    
    private func poplarSearchCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let cellCountOfRow = 2
        let spacing: CGFloat = 24
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let cellWidth: CGFloat = (screenWidth - spacing) / CGFloat(cellCountOfRow)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: cellWidth, height: 50)
        
        return layout
    }
    
    private func poplarNFTCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 72, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        return layout
    }
}

// TODO: 이후 삭제
extension CoinInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == poplarSearchCollectionView {
            return 14
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == poplarSearchCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PoplarSearchCollectionViewCell.identifier,
                for: indexPath
            ) as? PoplarSearchCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PoplarNFTCollectionViewCell.identifier,
                for: indexPath
            ) as? PoplarNFTCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
}
