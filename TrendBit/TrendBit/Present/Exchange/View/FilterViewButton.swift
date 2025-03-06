//
//  FilterViewButton.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit
import SnapKit

final class FilterViewButton: UIView {
    
    let tapGesture = UITapGestureRecognizer()
    private let titleLabel = UILabel()
    private let arrowUpImageView = UIImageView()
    private let arrowDownImageView = UIImageView()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.alpha = 0.5
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    private func configureView() {
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        arrowUpImageView.image = ImageAssets.arrowTriangleUpFill
        arrowUpImageView.contentMode = .scaleAspectFill
        arrowUpImageView.tintColor = .trendBitGray
        
        arrowDownImageView.image = ImageAssets.arrowTriangleDownFill
        arrowDownImageView.contentMode = .scaleAspectFill
        arrowDownImageView.tintColor = .trendBitGray
    }
    
    private func configureHierarchy() {
        self.addSubviews(
            titleLabel,
            arrowUpImageView,
            arrowDownImageView
        )
    }
    
    private func configureLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(titleLabel.snp.width).offset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        
        arrowUpImageView.snp.makeConstraints {
            $0.size.equalTo(7)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.snp.centerY)
        }
        
        arrowDownImageView.snp.makeConstraints {
            $0.size.equalTo(7)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.centerY)
        }
    }
}
