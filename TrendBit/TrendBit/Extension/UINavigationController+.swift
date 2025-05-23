//
//  UINavigationController+.swift
//  TrendBit
//
//  Created by 강민수 on 3/10/25.
//

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
