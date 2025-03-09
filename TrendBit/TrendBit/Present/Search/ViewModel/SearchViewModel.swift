//
//  SearchViewModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

final class SearchViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let popButtonDidTap: Observable<Void>
        let searchTextDidChange: Observable<String>
        let searchTitleStateDidChange: Observable<SearchViewType>
        let searchItemDidTap: Observable<SearchCoinEntity>
        let favoriteButtonDidTap: Observable<SearchCoinEntity>
    }
    
    struct Output {
        let searchText: Driver<String>
        let searchedData: Driver<[SearchCoinSection]>
        let scrollToTop: Driver<Void>
        let moveToOtherView: Driver<MoveToOtherViewType>
        let loadingIndicator: Driver<Bool>
        let presentError: Driver<(title: String, message: String)>
    }
    
    private let searchedTextRelay: BehaviorRelay<String>
    private let coinFavoriteService: CoinFavoriteService
    private let originalSearchCoinEntityRelay: BehaviorRelay<[SearchCoinEntity]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()
    
    init(
        searchedText: String,
        coinFavoriteService: CoinFavoriteService = DefaultCoinFavoriteService()
    ) {
        self.searchedTextRelay = BehaviorRelay(value: searchedText)
        self.coinFavoriteService = coinFavoriteService
    }
    
    deinit {
        print("SearchViewModel - Deinit")
    }
    
    func transform(from input: Input) -> Output {
        let searchTextRelay = BehaviorRelay(value: searchedTextRelay.value)
        let searchedDataRelay: BehaviorRelay<[SearchCoinSection]> = BehaviorRelay(value: [])
        let scrollToTopRelay = PublishRelay<Void>()
        let moveToOtherViewRelay = PublishRelay<MoveToOtherViewType>()
        let loadingIndicatorRelay = BehaviorRelay(value: true)
        let presentErrorRelay = PublishRelay<(title: String, message: String)>()
        
        Observable.combineLatest(input.viewDidLoad, searchedTextRelay)
            .map { CoingeckoEndPoint.search(query: $1) }
            .flatMap { endPoint in
                loadingIndicatorRelay.accept(true)
                return NetworkManager.shared.request(router: endPoint, responseType: SearchCoinDTO.self)
            }
            .bind(with: self) { owner, response in
                loadingIndicatorRelay.accept(false)
                switch response {
                case .success(let value):
                    let searchCoinEntity = value.toEntity()
                    let favoritedCoinEntity = searchCoinEntity.map {
                        $0.setFavoriteState(owner.coinFavoriteService.isFavoriteCoin(at: $0.coinID))
                    }
                    owner.originalSearchCoinEntityRelay.accept(favoritedCoinEntity)
                    
                case .failure(let error):
                    presentErrorRelay.accept((
                        title: StringLiterals.Alert.networkError,
                        message: error.errorDescription ?? ""
                    ))
                }
            }
            .disposed(by: disposeBag)
        
        input.popButtonDidTap
            .map { MoveToOtherViewType.pop }
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        input.searchTextDidChange
            .map { $0.trimmingCharacters(in: [" "]) }
            .bind(with: self) { owner, searchedText in
                if owner.searchedTextRelay.value == searchedText {
                    scrollToTopRelay.accept(())
                } else {
                    owner.searchedTextRelay.accept(searchedText)
                }
            }
            .disposed(by: disposeBag)
        
        input.searchTitleStateDidChange
            .bind(with: self) { owner, searchViewType in
                if searchViewType == .nft || searchViewType == .exchange {
                    searchedDataRelay.accept([SearchCoinSection(items: [])])
                } else {
                    searchedDataRelay.accept([SearchCoinSection(items: owner.originalSearchCoinEntityRelay.value)])
                }
            }
            .disposed(by: disposeBag)
        
        input.searchItemDidTap
            .map { MoveToOtherViewType.detail(id: $0.coinID) }
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        input.favoriteButtonDidTap
            .bind(with: self) { owner, searchCoinEntity in
                let isFavorite = owner.coinFavoriteService.isFavoriteCoin(at: searchCoinEntity.coinID)
                do {
                    if isFavorite {
                        try owner.coinFavoriteService.deleteItem(coinID: searchCoinEntity.coinID)
                    } else {
                        try owner.coinFavoriteService.createItem(coinID: searchCoinEntity.coinID)
                    }
                } catch {
                    presentErrorRelay.accept((
                        title: StringLiterals.Alert.localDataError,
                        message: error.localizedDescription
                    ))
                }
                
                let favoritedCoinEntity = owner.originalSearchCoinEntityRelay.value.map {
                    $0.setFavoriteState(owner.coinFavoriteService.isFavoriteCoin(at: $0.coinID))
                }
                owner.originalSearchCoinEntityRelay.accept(favoritedCoinEntity)
            }
            .disposed(by: disposeBag)
        
        originalSearchCoinEntityRelay
            .map { [SearchCoinSection(items: $0)] }
            .bind(to: searchedDataRelay)
            .disposed(by: disposeBag)
        
        return Output(
            searchText: searchTextRelay.asDriver(),
            searchedData: searchedDataRelay.asDriver(),
            scrollToTop: scrollToTopRelay.asDriver(onErrorJustReturn: ()),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: .pop),
            loadingIndicator: loadingIndicatorRelay.asDriver(),
            presentError: presentErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}

// MARK: - SearchViewType
extension SearchViewModel {
    
    enum SearchViewType: Int, CaseIterable {
        case coin
        case nft
        case exchange
        
        var title: String {
            switch self {
            case .coin: return StringLiterals.Search.coinTitle
            case .nft: return StringLiterals.Search.nftTitle
            case .exchange: return StringLiterals.Search.exchangeTitle
            }
        }
    }
}

// MARK: - Move To Other View Type
extension SearchViewModel {
    
    enum MoveToOtherViewType {
        case pop
        case detail(id: String)
    }
}
