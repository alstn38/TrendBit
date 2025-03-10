//
//  DateFormatterManager.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

final class DateFormatterManager {
    
    private let trendDateFormatter = DateFormatter()
    private let detailUpdateDateFormatter = DateFormatter()
    private let detailAllTheTimeDateFormatter = DateFormatter()
    
    static let shared = DateFormatterManager()
    
    private init() {
        trendDateFormatter.locale = Locale(identifier: "ko_KR")
        trendDateFormatter.dateFormat = "MM.dd HH:mm 기준"
        
        detailUpdateDateFormatter.locale = Locale(identifier: "ko_KR")
        detailUpdateDateFormatter.dateFormat = "MM/dd HH:mm:ss 업데이트"
        
        detailAllTheTimeDateFormatter.locale = Locale(identifier: "ko_KR")
        detailAllTheTimeDateFormatter.dateFormat = "yy년 M월 d일"
    }
    
    /// Trend Info Update 시간을 "MM.dd HH:mm 기준" 형식으로 반환하는 메서드
    func trendUpdateTimeString(date: Date) -> String {
        return trendDateFormatter.string(from: date)
    }
    
    /// Detail Info Update 시간을 "MM/dd HH:mm:ss 업데이트" 형식으로 반환하는 메서드
    func detailUpdateTimeString(date: Date) -> String {
        return detailUpdateDateFormatter.string(from: date)
    }
    
    /// Detail 역대 최고/최저 시간을 ""yy년 M월 d일"" 형식으로 반환하는 메서드
    func detailAllTheTimeString(dateString: String) -> String {
        guard let isoDate = ISO8601DateFormatter().date(from: dateString) else {
            return "시간 정보 없음"
        }
        return detailAllTheTimeDateFormatter.string(from: isoDate)
    }
}
