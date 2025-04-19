//
//  ExchangeViewModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ExchangeViewModel: InputOutputModel {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let currentPriceFilterButtonDidTap: Observable<Void>
        let previousDayFilterButton: Observable<Void>
        let transactionAmountFilterButton: Observable<Void>
    }
    
    struct Output {
        let exchangeData: Driver<[ExchangeSection]>
        let filterState: Driver<(SortFilterType, SortFilterState)>
        let loadingIndicator: Driver<Bool>
        let presentError: Driver<(title: String, message: String)>
    }
    
    private let originalExchangeData: BehaviorRelay<[TickerResponseDTO]> = BehaviorRelay(value: [])
    private let filterStateRelay = BehaviorRelay<(SortFilterType, SortFilterState)>(value: (.transactionAmount, .none))
    private let disposeBag = DisposeBag()
    
    func transform(from input: Input) -> Output {
        let exchangeDataRelay: BehaviorRelay<[ExchangeSection]> = BehaviorRelay(value: [])
        let loadingIndicatorRelay = BehaviorRelay(value: false)
        let presentErrorRelay = PublishRelay<(title: String, message: String)>()
        
        input.viewDidLoad
            .bind { _ in
                WebSocketManager.shared.connect()
            }
            .disposed(by: disposeBag)
        
        WebSocketManager.shared.tickerObservable
            .observe(on: MainScheduler.instance)
            .bind(to: originalExchangeData)
            .disposed(by: disposeBag)
        
        WebSocketManager.shared.socketErrorObservable
            .map { (StringLiterals.Alert.networkError, $0.localizedDescription) }
            .bind(to: presentErrorRelay)
            .disposed(by: disposeBag)
        
        input.currentPriceFilterButtonDidTap
            .bind(with: self) { owner, _ in
                owner.changeFilterState(inputType: .currentPrice)
                owner.originalExchangeData.accept(owner.originalExchangeData.value)
            }
            .disposed(by: disposeBag)
        
        input.previousDayFilterButton
            .bind(with: self) { owner, _ in
                owner.changeFilterState(inputType: .previousDay)
                owner.originalExchangeData.accept(owner.originalExchangeData.value)
            }
            .disposed(by: disposeBag)
        
        input.transactionAmountFilterButton
            .bind(with: self) { owner, _ in
                owner.changeFilterState(inputType: .transactionAmount)
                owner.originalExchangeData.accept(owner.originalExchangeData.value)
            }
            .disposed(by: disposeBag)
        
        originalExchangeData
            .bind(with: self) { owner, exchangeData in
                let (filterType, filterState) = owner.filterStateRelay.value
                let sortedData = owner.sortExchangeData(data: exchangeData, filterType: filterType, filterState: filterState)
                exchangeDataRelay.accept([ExchangeSection(items: sortedData)])
            }
            .disposed(by: disposeBag)
        
        return Output(
            exchangeData: exchangeDataRelay.asDriver(),
            filterState: filterStateRelay.asDriver(onErrorJustReturn: (.transactionAmount, .none)),
            loadingIndicator: loadingIndicatorRelay.asDriver(),
            presentError: presentErrorRelay.asDriver(onErrorJustReturn: (title: "", message: ""))
        )
    }
    
    /// 원본 데이터를 선택된 filter에 맞게 재정렬하여 반환하는 메서드
    private func sortExchangeData(
        data: [TickerResponseDTO],
        filterType: SortFilterType,
        filterState: SortFilterState
    ) -> [ExchangeDataEntity] {
        
        if filterState == .none {
            return data.sorted { $0.accTradePrice24h > $1.accTradePrice24h }.map { $0.toEntity() }
        }
        
        switch filterType {
        case .currentPrice:
            if filterState == .ascending {
                return data.sorted { $0.tradePrice < $1.tradePrice }.map { $0.toEntity() }
            } else {
                return data.sorted { $0.tradePrice > $1.tradePrice }.map { $0.toEntity() }
            }
            
        case .previousDay:
            if filterState == .ascending {
                return data.sorted { $0.signedChangeRate < $1.signedChangeRate }.map { $0.toEntity() }
            } else {
                return data.sorted { $0.signedChangeRate > $1.signedChangeRate }.map { $0.toEntity() }
            }
            
        case .transactionAmount:
            if filterState == .ascending {
                return data.sorted { $0.accTradePrice24h < $1.accTradePrice24h }.map { $0.toEntity() }
            } else {
                return data.sorted { $0.accTradePrice24h > $1.accTradePrice24h }.map { $0.toEntity() }
            }
        }
    }
    
    /// Filter 타입이 변경되었을 경우 필터를 변경하는 메서드
    private func changeFilterState(inputType: SortFilterType) {
        let (currentFilterType, currentFilterState) = filterStateRelay.value
        
        if currentFilterType != inputType {
            filterStateRelay.accept((currentFilterType, .none))
            filterStateRelay.accept((inputType, .descending))
        } else {
            if currentFilterState == .none {
                filterStateRelay.accept((inputType, .descending))
            } else if currentFilterState == .descending {
                filterStateRelay.accept((inputType, .ascending))
            } else {
                filterStateRelay.accept((inputType, .none))
            }
        }
    }
}

// MARK: - Sort Filter Type,  Filter State
extension ExchangeViewModel {
    
    enum SortFilterType {
        case currentPrice
        case previousDay
        case transactionAmount
    }
    
    enum SortFilterState {
        case none
        case descending
        case ascending
    }
}
