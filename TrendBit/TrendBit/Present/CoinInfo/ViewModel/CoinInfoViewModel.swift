//
//  CoinInfoViewModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

final class CoinInfoViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let searchDidTap: Observable<String>
        let poplarSearchTap: Observable<TrendCoinInfo>
    }
    
    struct Output {
        let updateTime: Driver<String>
        let poplarSearchData: Driver<[PoplarSearchSection]>
        let poplarNFTData: Driver<[PoplarNFTSection]>
        let moveToOtherView: Driver<MoveToOtherViewType>
        let loadingIndicator: Driver<Bool>
        let presentError: Driver<(title: String, message: String)>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let updateTimeRelay = BehaviorRelay(value: "")
        let poplarSearchDataRelay: BehaviorRelay<[PoplarSearchSection]> = BehaviorRelay(value: [])
        let poplarNFTDataRelay: BehaviorRelay<[PoplarNFTSection]> = BehaviorRelay(value: [])
        let moveToOtherViewRelay = PublishRelay<MoveToOtherViewType>()
        let loadingIndicatorRelay = BehaviorRelay(value: true)
        let presentErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.viewDidLoad
            .flatMap { Observable<Int>.timer(.seconds(0), period: .seconds(600), scheduler: MainScheduler.instance) }
            .map { _ in CoingeckoEndPoint.trendInfo }
            .flatMap { endPoint in
                loadingIndicatorRelay.accept(true)
                return NetworkManager.shared.request(router: endPoint, responseType: TrendInfoDTO.self)
            }
            .bind(with: self) { owner, response in
                loadingIndicatorRelay.accept(false)
                switch response {
                case .success(let value):
                    let trendInfo = value.toEntity()
                    updateTimeRelay.accept(trendInfo.updateTime)
                    poplarSearchDataRelay.accept([PoplarSearchSection(items: trendInfo.trendCoinInfo)])
                    poplarNFTDataRelay.accept([PoplarNFTSection(items: trendInfo.trendNFTInfo)])
                    
                case .failure(let error):
                    presentErrorRelay.accept((
                        title: StringLiterals.Alert.networkError,
                        message: error.errorDescription ?? ""
                    ))
                }
            }
            .disposed(by: disposeBag)
        
        input.searchDidTap
            .map { $0.trimmingCharacters(in: [" "]) }
            .filter { !$0.isEmpty }
            .map { MoveToOtherViewType.search(searchText: $0) }
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        input.poplarSearchTap
            .map { MoveToOtherViewType.detail(id: $0.coinID) }
            .bind(to: moveToOtherViewRelay)
            .disposed(by: disposeBag)
        
        return Output(
            updateTime: updateTimeRelay.asDriver(),
            poplarSearchData: poplarSearchDataRelay.asDriver(),
            poplarNFTData: poplarNFTDataRelay.asDriver(),
            moveToOtherView: moveToOtherViewRelay.asDriver(onErrorJustReturn: .search(searchText: "")),
            loadingIndicator: loadingIndicatorRelay.asDriver(),
            presentError: presentErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
}

// MARK: - Move To Other View Type
extension CoinInfoViewModel {
    
    enum MoveToOtherViewType {
        case search(searchText: String)
        case detail(id: String)
    }
}
