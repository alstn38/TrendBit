//
//  InputOutputModel.swift
//  TrendBit
//
//  Created by 강민수 on 3/8/25.
//

import Foundation

protocol InputOutputModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
