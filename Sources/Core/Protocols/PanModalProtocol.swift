//
//  PanModalPresentable.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 24.06.2024.
//

import Foundation
import PanModal

public protocol PanModalProtocol: PanModalPresentable {}

public extension PanModalProtocol {
    var cornerRadius: CGFloat { return 11.0 }
    var allowsDragToDismiss: Bool { return false }
//    var shortFormHeight: PanModalHeight { return .intrinsicHeight }
//    var longFormHeight: PanModalHeight { return .contentHeight(400) }
}
