//
//  DateFormatterManager.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

final class DateFormatterManager {
    
    private let trendDateFormatter = DateFormatter()
    
    static let shared = DateFormatterManager()
    
    private init() {
        trendDateFormatter.locale = Locale(identifier: "ko_KR")
        trendDateFormatter.dateFormat = "MM.dd HH:mm 기준"
    }
    
    /// Trend Info Update 시간을 "MM.dd HH:mm 기준" 형식으로 반환하는 메서드
    func trendUpdateTimeString(date: Date) -> String {
        return trendDateFormatter.string(from: date)
    }
}
