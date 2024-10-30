//
//  FontExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol FontTypeProtocol {
    static var light: String { get }
    static var regular: String { get }
    static var medium: String { get }
    static var semiBold: String { get }
    static var bold: String { get }
}

public protocol FontSizeProtocol {
    static var size8: CGFloat { get }
    static var size10: CGFloat { get }
    static var size12: CGFloat { get }
    static var size14: CGFloat { get }
    static var size16: CGFloat { get }
    static var size20: CGFloat { get }
}

extension UIFont {
    public class func font(type: String, _ size: CGFloat) -> UIFont {
        return UIFont(name: type, size: size)!
    }
}
