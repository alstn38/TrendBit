//
//  LocalDataError.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation

enum LocalError: Error {
    case createError
    case deleteError
}

extension LocalError: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .createError: 
            return "데이터 저장에 오류가 발생했습니다."
        case .deleteError:
            return "데이터 삭제에 오류가 발생했습니다."
        }
    }
}
