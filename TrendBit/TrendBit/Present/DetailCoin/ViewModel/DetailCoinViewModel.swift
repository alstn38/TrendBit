//
//  DetailCoinViewModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

protocol DetailCoinViewModelDelegate: AnyObject {
    func detailCoinViewModelDelegate(_ viewModel: DetailCoinViewModel, didChangeFavorite coinID: String)
}

final class DetailCoinViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let popButtonDidTap: Observable<Void>
        let favoriteButtonDidTap: Observable<Void>
        let moreTypeInfoButtonDidTap: Observable<Void>
        let investmentInfoButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let isFavoriteCoin: Driver<Bool>
        let detailCoinData: Driver<CoinDetailEntity>
        let moveToOtherView: Driver<MoveToOtherViewType>
        let loadingIndicator: Driver<Bool>
        let presentError: Driver<(title: String, message: String)>
        let presentToastError: Driver<String>
    }
    
    weak var delegate: DetailCoinViewModelDelegate?
    private let coinID: String
    private let coinFavoriteService: CoinFavoriteService
    private let disposeBag = DisposeBag()
    
    init(
        coinID: String,
        coinFavoriteService: CoinFavoriteService = DefaultCoinFavoriteService()
    ) {
        self.coinID = coinID
        self.coinFavoriteService = coinFavoriteService
    }
    
    func transform(from input: Input) -> Output {
        let isFavoriteCoinRelay = BehaviorRelay(value: false)
        let detailCoinDataRelay: BehaviorRelay<CoinDetailEntity> = BehaviorRelay(value: CoinDetailEntity.dummy())
        let moveToOtherViewRelay = PublishRelay<MoveToOtherViewType>()
        let loadingIndicatorRelay = BehaviorRelay(value: false)
        let presentErrorRelay = PublishRelay<(title: String, message: String)>()
        let presentToastErrorRelay = PublishRelay<String>()
        
        input.viewDidLoad
            .withUnretained(self)
            .map { CoingeckoEndPoint.detail(id: $0.0.coinID) }
            .flatMap { endPoint in
                loadingIndicatorRelay.accept(true)
                return NetworkManager.shared.request(router: endPoint, responseType: [CoinDetailDTO].self)
            }
            .bind(with: self) { owner, response in
                loadingIndicatorRelay.accept(false)
                let isFavorite = owner.coinFavoriteService.isFavoriteCoin(at: owner.coinID)
                isFavoriteCoinRelay.accept(isFavorite)
                
                switch response {
                case .success(let value):
                    guard let coinDetailDTO = value.first else { return }
                    let coinDetailEntity = coinDetailDTO.toEntity()
                    detailCoinDataRelay.accept(coinDetailEntity)
                    
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
        
        input.favoriteButtonDidTap
            .bind(with: self) { owner, _ in
                let coinID = owner.coinID
                let isFavorite = owner.coinFavoriteService.isFavoriteCoin(at: coinID)
                do {
                    if isFavorite {
                        try owner.coinFavoriteService.deleteItem(coinID: coinID)
                    } else {
                        try owner.coinFavoriteService.createItem(coinID: coinID)
                    }
                    isFavoriteCoinRelay.accept(!isFavorite)
                    owner.delegate?.detailCoinViewModelDelegate(owner, didChangeFavorite: coinID)
                } catch {
                    presentErrorRelay.accept((
                        title: StringLiterals.Alert.localDataError,
                        message: error.localizedDescription
                    ))
                }
            }
            .disposed(by: disposeBag)
        
        Observable.merge(input.moreTypeInfoButtonDidTap, input.investmentInfoButtonDidTap)
            .bind { _ in
                presentToastErrorRelay.accept(StringLiterals.Toast.notReady)
            }
            .disposed(by: disposeBag)
        
        return Output(
            isFavoriteCoin: isFavoriteCoinRelay.asDriver(),
            detailCoinData: detailCoinDataRelay.asDriver(),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: .pop),
            loadingIndicator: loadingIndicatorRelay.asDriver(),
            presentError: presentErrorRelay.asDriver(onErrorJustReturn: (title: "", message: "")),
            presentToastError: presentToastErrorRelay.asDriver(onErrorJustReturn: "")
        )
    }
}

// MARK: - Move To Other View Type
extension DetailCoinViewModel {
    
    enum MoveToOtherViewType {
        case pop
    }
}
