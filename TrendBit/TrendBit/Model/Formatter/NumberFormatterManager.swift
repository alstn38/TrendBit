//
//  NumberFormatterManager.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

final class NumberFormatterManager {
    
    static let shared = NumberFormatterManager()
    
    private let numberFormatter = NumberFormatter()
    private let percentNumberFormatter = NumberFormatter()
    
    private init() {
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.groupingSeparator = ","
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        
        percentNumberFormatter.numberStyle = .percent
        percentNumberFormatter.minimumFractionDigits = 2
    }
    
    /// TrendBit 소수점 표기 방식 String을 반환하는 메서드
    /// - 소수점 3자리에서 반올림 하여 소수점 2자리까지 표시
    /// - 정수 영역은 세 자리마다 쉼표로 구분하여 표시
    func pointNumberString(from value: Double) -> String {
        let digit: Double = pow(10, 2)
        let roundNumber = round(value * digit) / digit
        
        return numberFormatter.string(for: roundNumber) ?? "Error"
    }
    
    /// TrendBit Percent 표기 방식 String을 반환하는 메서드
    /// - 소수점 2자리까지 필수적으로 표시됩니다.
    func percentString(from value: Double) -> String {
        return percentNumberFormatter.string(for: value) ?? "Error"
    }
    
    /// TrendBit Percent 표기 방식 String을 반환하는 메서드
    /// - 소수점 2자리까지 필수적으로 표시됩니다.
    func percentDidvidHundred(from value: Double) -> String {
        let value = value / 100
        return percentNumberFormatter.string(for: value) ?? "Error"
    }
    
    /// TrendBit 백만 단위 표기 방식 String을 반환하는 메서드
    /// 백만 이하 단위일 시 기본값으로 표시됩니다.
    /// 정수만 표시됩니다.
    func millionString(from value: Double) -> String {
        var unitString: String = "원"
        var price = value
        
        if value >= 1000000 {
            unitString = "백만"
            price = round(price / 1000000)
        }
        
        guard let formattedPrice = numberFormatter.string(for: price) else {
            return "Error"
        }
        
        return formattedPrice + unitString
    }
}
