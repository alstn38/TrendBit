//
//  CoinInfoViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import SnapKit

final class CoinInfoViewController: UIViewController {
    
    private let viewModel: CoinInfoViewModel
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let lineView = UIView()
    private let searchView = CoinInfoSearchView()
    private let popularSearchTitleLabel = UILabel()
    private let updateTimeLabel = UILabel()
    private lazy var poplarSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: poplarSearchCollectionFlowLayout())
    private let popularNFTTitleLabel = UILabel()
    private lazy var poplarNFTCollectionView = UICollectionView(frame: .zero, collectionViewLayout: poplarNFTCollectionFlowLayout())
    
    private let poplarSearchDataSource = RxCollectionViewSectionedReloadDataSource<PoplarSearchSection> {
        dataSource, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PoplarSearchCollectionViewCell.identifier,
            for: indexPath
        ) as? PoplarSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(with: item)
        return cell
    }
    
    private let poplarNFTDataSource = RxCollectionViewSectionedReloadDataSource<PoplarNFTSection> {
        dataSource, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PoplarNFTCollectionViewCell.identifier,
            for: indexPath
        ) as? PoplarNFTCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(with: item)
        return cell
    }
    
    init(viewModel: CoinInfoViewModel) {
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
        let input = CoinInfoViewModel.Input(
            viewDidLoad: Observable.just(()),
            searchDidTap: searchView.searchTextField.rx.controlEvent(.editingDidEnd)
                .withLatestFrom(searchView.searchTextField.rx.text.orEmpty).asObservable(),
            poplarSearchTap: poplarSearchCollectionView.rx.modelSelected(TrendCoinInfo.self).asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.updateTime
            .drive(updateTimeLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.poplarSearchData
            .drive(poplarSearchCollectionView.rx.items(dataSource: poplarSearchDataSource))
            .disposed(by: disposeBag)
        
        output.poplarNFTData
            .drive(poplarNFTCollectionView.rx.items(dataSource: poplarNFTDataSource))
            .disposed(by: disposeBag)
        
        output.moveToOtherView
            .drive(with: self) { owner, viewType in
                switch viewType {
                case .search(let searchText):
                    let viewModel = SearchViewModel(searchedText: searchText)
                    let viewController = SearchViewController(viewModel: viewModel)
                    owner.navigationController?.pushViewController(viewController, animated: true)
                    
                case .detail(let id):
                    let viewModel = DetailCoinViewModel(coinID: id)
                    let viewController = DetailCoinViewController(viewModel: viewModel)
                    owner.navigationController?.pushViewController(viewController, animated: true)
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
        
        titleLabel.text = StringLiterals.CoinInfo.title
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.5)
        
        popularSearchTitleLabel.text = StringLiterals.CoinInfo.popularSearchTitle
        popularSearchTitleLabel.textColor = UIColor(resource: .trendBitNavy)
        popularSearchTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        updateTimeLabel.textColor = UIColor(resource: .trendBitGray)
        updateTimeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        poplarSearchCollectionView.backgroundColor = UIColor(resource: .trendBitWhite)
        poplarSearchCollectionView.register(
            PoplarSearchCollectionViewCell.self,
            forCellWithReuseIdentifier: PoplarSearchCollectionViewCell.identifier
        )
        
        popularNFTTitleLabel.text = StringLiterals.CoinInfo.popularNFTTitle
        popularNFTTitleLabel.textColor = UIColor(resource: .trendBitNavy)
        popularNFTTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        poplarNFTCollectionView.backgroundColor = UIColor(resource: .trendBitWhite)
        poplarNFTCollectionView.showsHorizontalScrollIndicator = false
        poplarNFTCollectionView.register(
            PoplarNFTCollectionViewCell.self,
            forCellWithReuseIdentifier: PoplarNFTCollectionViewCell.identifier
        )
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
        let spacing: CGFloat = 6
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let cellWidth: CGFloat = (screenWidth - spacing) / CGFloat(cellCountOfRow)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = .zero
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
