//
//  SearchViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import SnapKit

final class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private let favoriteInfoUpdate = PublishRelay<Void>()
    private let favoriteButtonDidTapRelay = PublishRelay<SearchCoinEntity>()
    private let searchStateRelay: BehaviorRelay<SearchViewModel.SearchViewType> = BehaviorRelay(value: .coin)
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SearchCoinSection> {
        [weak self] dataSource, tableView, indexPath, item in
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CoinSearchTableViewCell.identifier,
            for: indexPath
        ) as? CoinSearchTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(with: item)
        cell.favoriteButton.rx.tap
            .map { item }
            .bind { item in
                self?.favoriteButtonDidTapRelay.accept(item)
            }
            .disposed(by: cell.disposeBag)
        
        return cell
    }
    
    private let popButton = UIButton()
    private let searchTextField = UITextField()
    private let lineView = UIView()
    private let searchTitleStackView = UIStackView()
    private let searchTitleButton = SearchViewModel.SearchViewType.allCases.map { _ in UIButton() }
    private let pageSelectBackgroundView = UIView()
    private let pageSelectView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchTableView = UITableView()
    private let nftTableView = UITableView()
    private let exchangeTableView = UITableView()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SearchViewController - Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let input = SearchViewModel.Input(
            viewDidLoad: Observable.just(()),
            popButtonDidTap: popButton.rx.tap.asObservable(),
            searchTextDidChange: searchTextField.rx.controlEvent(.editingDidEnd)
                .withLatestFrom(searchTextField.rx.text.orEmpty).asObservable(),
            searchItemDidTap: searchTableView.rx.modelSelected(SearchCoinEntity.self).asObservable(),
            favoriteButtonDidTap: favoriteButtonDidTapRelay.asObservable(),
            favoriteInfoDidUpdate: favoriteInfoUpdate.asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.searchText
            .drive(searchTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.searchedData
            .drive(searchTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.scrollToTop
            .drive(with: self) { owner, _ in
                owner.searchTableView.setContentOffset(.zero, animated: false)
            }
            .disposed(by: disposeBag)
        
        output.moveToOtherView
            .drive(with: self) { owner, viewType in
                switch viewType {
                case .pop:
                    owner.navigationController?.popViewController(animated: true)
                    
                case .detail(let id):
                    let viewModel = DetailCoinViewModel(coinID: id)
                    let viewController = DetailCoinViewController(viewModel: viewModel)
                    owner.configureDetailCoinViewModelDelegate(viewModel)
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
        
        output.presentToastError
            .drive { message in
                AlertToastManager.showToast(message: message)
            }
            .disposed(by: disposeBag)
        
        scrollView.rx.didEndDecelerating
            .withLatestFrom(scrollView.rx.contentOffset)
            .bind(with: self) { owner, point in
                let screenWidth: CGFloat = owner.view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
                let currentPage = Int(round(point.x / screenWidth))
                let type = SearchViewModel.SearchViewType(rawValue: currentPage) ?? .coin
                owner.searchStateRelay.accept(type)
                owner.configureSearchTitleState(type)
            }
            .disposed(by: disposeBag)
        
        for (button, searchType) in zip(searchTitleButton, SearchViewModel.SearchViewType.allCases) {
            button.rx.tap
                .map { searchType }
                .bind(with: self, onNext: { owner, type in
                    owner.searchStateRelay.accept(type)
                    owner.configureSearchTitleState(type)
                    owner.configurePageScrollView(to: type.rawValue)
                })
                .disposed(by: disposeBag)
        }
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
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        searchTableView.backgroundColor = UIColor(resource: .trendBitWhite)
        searchTableView.rowHeight = 60
        searchTableView.showsVerticalScrollIndicator = false
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.register(
            CoinSearchTableViewCell.self,
            forCellReuseIdentifier: CoinSearchTableViewCell.identifier
        )
        
        nftTableView.backgroundColor = .yellow
        exchangeTableView.backgroundColor = .cyan
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            popButton,
            searchTextField,
            lineView,
            searchTitleStackView,
            pageSelectBackgroundView,
            pageSelectView,
            scrollView
        )
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            searchTableView,
            nftTableView,
            exchangeTableView
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
            $0.centerX.equalTo(searchTitleButton[0].snp.centerX)
            $0.width.equalTo(searchTitleButton[0].snp.width)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(pageSelectBackgroundView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(scrollView)
            $0.edges.equalTo(scrollView)
        }
        
        searchTableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(contentView)
            $0.width.equalTo(view.snp.width)
        }
        
        nftTableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(searchTableView.snp.trailing)
            $0.width.equalTo(view.snp.width)
        }
        
        exchangeTableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView)
            $0.leading.equalTo(nftTableView.snp.trailing)
            $0.trailing.equalTo(contentView)
            $0.width.equalTo(view.snp.width)
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
    
    private func configureSearchTitleState(_ inputType: SearchViewModel.SearchViewType) {
        for (button, searchType) in zip(searchTitleButton, SearchViewModel.SearchViewType.allCases) {
            if searchType == inputType {
                button.setTitleColor(UIColor(resource: .trendBitNavy), for: .normal)
            } else {
                button.setTitleColor(UIColor(resource: .trendBitGray), for: .normal)
            }
        }
        
        pageSelectView.snp.remakeConstraints {
            $0.centerY.equalTo(pageSelectBackgroundView)
            $0.height.equalTo(2)
            $0.centerX.equalTo(searchTitleButton[inputType.rawValue].snp.centerX)
            $0.width.equalTo(searchTitleButton[inputType.rawValue].snp.width)
        }
    }
    
    private func configurePageScrollView(to index: Int) {
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        scrollView.setContentOffset(CGPoint(x: Int(screenWidth) * index, y: 0), animated: true)
    }
    
    private func configureDetailCoinViewModelDelegate(_ viewModel: DetailCoinViewModel) {
        viewModel.delegate = self
    }
}

// MARK: - DetailCoinViewModelDelegate
extension SearchViewController: DetailCoinViewModelDelegate {
    
    func detailCoinViewModelDelegate(_ viewModel: DetailCoinViewModel, didChangeFavorite coinID: String) {
        favoriteInfoUpdate.accept(())
    }
}
