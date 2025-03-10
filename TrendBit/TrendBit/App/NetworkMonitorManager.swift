//
//  NetworkMonitorManager.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import UIKit
import Network

final class NetworkMonitorManager {
    
    static let shared = NetworkMonitorManager()
    private(set) var isConnected: Bool = false
    
    private init() { }
    
    private let networkPathMonitor = NWPathMonitor()
    
    func startMonitoring() {
        networkPathMonitor.start(queue: .global())
        
        networkPathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            if path.status != .satisfied {
                self?.presentNetworkAlert()
            }
        }
    }
    
    func stopMonitoring() {
        networkPathMonitor.cancel()
    }
    
    private func presentNetworkAlert() {
        DispatchQueue.main.async {
            guard
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first,
                let viewController = window.rootViewController
            else { return }

            let alertViewController = AlertViewController()
            alertViewController.modalPresentationStyle = .overFullScreen
            viewController.present(alertViewController, animated: false)
        }
    }
}
