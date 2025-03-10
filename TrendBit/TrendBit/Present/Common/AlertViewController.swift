//
//  AlertViewController.swift
//  TrendBit
//
//  Created by 강민수 on 3/11/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AlertViewController: UIViewController {
    
    private let alertBackgroundView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let lineView = UIView()
    private let retryButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
    
    private func configureBind() {
        retryButton.rx.tap
            .bind(with: self) { owner, _ in
                if NetworkMonitorManager.shared.isConnected {
                    owner.dismiss(animated: false)
                } else {
                    AlertToastManager.showToast(message: StringLiterals.Toast.connectError)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .trendBitNavy).withAlphaComponent(0.5)
        
        alertBackgroundView.backgroundColor = UIColor(resource: .trendBitWhite)
        
        titleLabel.text = StringLiterals.Alert.guideTitle
        titleLabel.textColor = UIColor(resource: .trendBitNavy)
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        
        messageLabel.text = StringLiterals.Alert.connectError
        messageLabel.textColor = UIColor(resource: .trendBitNavy)
        messageLabel.font = .systemFont(ofSize: 13, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        
        lineView.backgroundColor = UIColor(resource: .trendBitGray).withAlphaComponent(0.3)
        
        retryButton.setTitle(StringLiterals.Alert.retry, for: .normal)
        retryButton.setTitleColor(UIColor(resource: .trendBitNavy), for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    }
    
    private func configureHierarchy() {
        view.addSubviews(
            alertBackgroundView,
            titleLabel,
            messageLabel,
            lineView,
            retryButton
        )
    }
    
    private func configureLayout() {
        alertBackgroundView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertBackgroundView).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalTo(alertBackgroundView).inset(24)
            $0.bottom.equalTo(lineView.snp.top).offset(-18)
        }
        
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(retryButton.snp.top)
        }
        
        retryButton.snp.makeConstraints {
            $0.bottom.equalTo(alertBackgroundView)
            $0.horizontalEdges.equalTo(alertBackgroundView)
            $0.height.equalTo(48)
        }
    }
}
