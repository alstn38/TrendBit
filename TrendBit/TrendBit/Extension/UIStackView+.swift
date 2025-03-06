//
//  UIStackView+.swift
//  TrendBit
//
//  Created by 강민수 on 3/7/25.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
