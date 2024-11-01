//
//  RoundableViewProtocol.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol ReusableViewProtocol {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableViewProtocol where Self: UIView {
    static var defaultReuseIdentifier: String { String(describing: self) }
}
