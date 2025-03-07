//
//  SearchViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let popButton = UIButton()
    private let searchTextField = UITextField()
    private let lineView = UIView()
    private let searchTitleStackView = UIStackView()
    private let searchTitleButton = SearchViewModel.SearchViewType.allCases.map { _ in UIButton() }
    private let pageSelectBackgroundView = UIView()
    private let pageSelectView = UIView()
    private lazy var searchPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        searchPageCollectionView.register(CoinSearchCollectionViewCell.self, forCellWithReuseIdentifier: CoinSearchCollectionViewCell.identifier) // TODO: 이후 삭제
        searchPageCollectionView.register(NFTSearchCollectionViewCell.self, forCellWithReuseIdentifier: NFTSearchCollectionViewCell.identifier) // TODO: 이후 삭제
        searchPageCollectionView.register(ExchangeSearchCollectionViewCell.self, forCellWithReuseIdentifier: ExchangeSearchCollectionViewCell.identifier) // TODO: 이후 삭제
        searchPageCollectionView.delegate = self // TODO: 이후 삭제
        searchPageCollectionView.dataSource = self // TODO: 이후 삭제
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        
        popButton.setImage(ImageAssets.arrowLeft, for: .normal)
        popButton.tintColor = UIColor(resource: .trendBitNavy)
        
        searchTextField.placeholder = StringLiterals.Search.searchTextFieldPlaceholder
        searchTextField.textColor = UIColor(resource: .trendBitNavy)
        searchTextField.font = .systemFont(ofSize: 13, weight: .regular)
        searchTextField.returnKeyType = .search
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.5)
        
        searchTitleStackView.axis = .horizontal
        searchTitleStackView.alignment = .fill
        searchTitleStackView.distribution = .fillEqually
        
        for (button, searchType) in zip(searchTitleButton, SearchViewModel.SearchViewType.allCases) {
            button.setTitle(searchType.title, for: .normal)
            button.setTitleColor(UIColor(resource: .trendBitGray), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        }
        
        pageSelectBackgroundView.backgroundColor = UIColor(resource: .trendBitGray)
        
        pageSelectView.backgroundColor = UIColor(resource: .trendBitNavy)
        
        searchPageCollectionView.backgroundColor = .trendBitWhite
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            popButton,
            searchTextField,
            lineView,
            searchTitleStackView,
            pageSelectBackgroundView,
            pageSelectView,
            searchPageCollectionView
        )
        
        searchTitleButton.forEach {
            searchTitleStackView.addArrangedSubviews($0)
        }
    }
    
    private func configureLayout() {
        popButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(12)
            $0.size.equalTo(24)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalTo(popButton)
            $0.leading.equalTo(popButton.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(popButton.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        searchTitleStackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        pageSelectBackgroundView.snp.makeConstraints {
            $0.top.equalTo(searchTitleStackView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        pageSelectView.snp.makeConstraints {
            $0.centerY.equalTo(pageSelectBackgroundView)
            $0.height.equalTo(2)
            $0.leading.equalToSuperview() // TODO: 이후 삭제
            $0.width.equalTo(120) // TODO: 이후 삭제
        }
        
        searchPageCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageSelectBackgroundView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let groupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let sectionLayout = NSCollectionLayoutSection(group: groupLayout)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        
        let layout = UICollectionViewCompositionalLayout(section: sectionLayout)
        return layout
    }
}


// TODO: 이후 삭제
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SearchViewModel.SearchViewType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CoinSearchCollectionViewCell.identifier,
                for: indexPath
            ) as? CoinSearchCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NFTSearchCollectionViewCell.identifier,
                for: indexPath
            ) as? NFTSearchCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExchangeSearchCollectionViewCell.identifier,
                for: indexPath
            ) as? ExchangeSearchCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        }
    }
}
