//
//  RoundableViewProtocol.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol RoundableViewProtocol {
    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor? { get set }
}
