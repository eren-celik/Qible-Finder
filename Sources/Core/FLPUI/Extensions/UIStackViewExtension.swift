//
//  UIStackViewExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 9.04.2023.
//

import UIKit

extension UIStackView {

    public func removeAll() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }

    public func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addArrangedSubview($0) }
    }
}
