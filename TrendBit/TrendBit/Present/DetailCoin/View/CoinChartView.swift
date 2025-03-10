//
//  CoinChartView.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import SwiftUI
import Charts

struct CoinChartView: View {
    
    private var data: [CoinDetailChartData] = []
    
    /// 최소값에서 0.95배만큼의 값을 뺀다. (그래프가 더 잘보이기 위함)
    private var removePrice: Double {
        return (data.map { $0.changePrices }.min() ?? 0.0) * 0.95
    }
    
    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.element.id) {
                index,
                coin in
                AreaMark(
                    x: .value("index", index),
                    y: .value("price", coin.changePrices - removePrice)
                )
                
                LineMark(
                    x: .value("index", index),
                    y: .value("price", coin.changePrices - removePrice)
                )
                .foregroundStyle(Color.trendBitBlue)
                .lineStyle(.init(lineWidth: 2))
                .interpolationMethod(.cardinal)
            }
        }
        .foregroundStyle(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.trendBitBlue.opacity(0.9),
                    Color.trendBitBlue.opacity(0.1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .background(Color.trendBitWhite)
    }
    
    mutating func configureChart(_ data: [CoinDetailChartData]) {
        self.data = data
    }
}
