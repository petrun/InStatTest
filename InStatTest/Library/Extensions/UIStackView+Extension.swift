//
//  UIStackView+Extension.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        for view in removedSubviews {
            if view.superview != nil {
                NSLayoutConstraint.deactivate(view.constraints)
                view.removeFromSuperview()
            }
        }
    }
}
