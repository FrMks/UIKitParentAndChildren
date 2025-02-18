//
//  UIView.swift
//  UIKitParentAndChildren
//
//  Created by Максим Французов on 18.02.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView ...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
