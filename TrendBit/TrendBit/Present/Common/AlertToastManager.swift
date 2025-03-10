//
//  AlertToastManager.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import UIKit
import Toast

final class AlertToastManager {
    
    static func showToast(message: String) {
        DispatchQueue.main.async {
            guard
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first,
                let view = window.rootViewController?.view
            else { return }

            view.makeToast(message)
        }
    }
}
