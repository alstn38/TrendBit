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
        let searchItemDidTap: Observable<SearchCoinEntity>
        let favoriteButtonDidTap: Observable<SearchCoinEntity>
        let favoriteInfoDidUpdate: Observable<Void>
    }
    
    struct Output {
        let searchText: Driver<String>
        let searchedData: Driver<[SearchCoinSection]>
        let scrollToTop: Driver<Void>
        let moveToOtherView: Driver<MoveToOtherViewType>
        let loadingIndicator: Driver<Bool>
        let presentError: Driver<(title: String, message: String)>
        let presentToastError: Driver<String>
    }
    
    private let searchedTextRelay: BehaviorRelay<String>
    private let coinFavoriteService: CoinFavoriteService
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
        let presentToastErrorRelay = PublishRelay<String>()
        
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
                    searchedDataRelay.accept([SearchCoinSection(items: favoritedCoinEntity)])
                    
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
                } else if searchedText.isEmpty {
                    presentToastErrorRelay.accept(StringLiterals.Toast.noResult)
                    searchedDataRelay.accept([])
                } else {
                    owner.searchedTextRelay.accept(searchedText)
                }
            }
            .disposed(by: disposeBag)
        
        input.searchItemDidTap
            .map { MoveToOtherViewType.detail(id: $0.coinID) }
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        input.favoriteButtonDidTap
            .bind(with: self) { owner, searchCoinEntity in
                let coinID = searchCoinEntity.coinID
                let coinName = searchCoinEntity.coinName
                let isFavorite = owner.coinFavoriteService.isFavoriteCoin(at: coinID)
                do {
                    if isFavorite {
                        try owner.coinFavoriteService.deleteItem(coinID: coinID)
                        presentToastErrorRelay.accept(coinName + StringLiterals.Toast.deleteFavoriteCoin)
                    } else {
                        try owner.coinFavoriteService.createItem(coinID: coinID)
                        presentToastErrorRelay.accept(coinName + StringLiterals.Toast.addFavoriteCoin)
                    }
                } catch {
                    presentErrorRelay.accept((
                        title: StringLiterals.Alert.localDataError,
                        message: error.localizedDescription
                    ))
                }
                
                guard let searchCoinEntity = searchedDataRelay.value.first?.items else { return }
                let favoritedCoinEntity = searchCoinEntity.map {
                    $0.setFavoriteState(owner.coinFavoriteService.isFavoriteCoin(at: $0.coinID))
                }
                searchedDataRelay.accept([SearchCoinSection(items: favoritedCoinEntity)])
            }
            .disposed(by: disposeBag)
        
        input.favoriteInfoDidUpdate
            .bind(with: self) { owner, _ in
                guard let searchCoinEntity = searchedDataRelay.value.first?.items else { return }
                let favoritedCoinEntity = searchCoinEntity.map {
                    $0.setFavoriteState(owner.coinFavoriteService.isFavoriteCoin(at: $0.coinID))
                }
                searchedDataRelay.accept([SearchCoinSection(items: favoritedCoinEntity)])
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchText: searchTextRelay.asDriver(),
            searchedData: searchedDataRelay.asDriver(),
            scrollToTop: scrollToTopRelay.asDriver(onErrorJustReturn: ()),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: .pop),
            loadingIndicator: loadingIndicatorRelay.asDriver(),
            presentError: presentErrorRelay.asDriver(onErrorJustReturn: (title: "", message: "")),
            presentToastError: presentToastErrorRelay.asDriver(onErrorJustReturn: "")
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
