//
//  RoundableViewProtocol.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol NibLoadableViewProtocol {
    static var nibName: String { get }
    var typeName: String { get }
    static var bundle: Bundle? { get }
}

extension NibLoadableViewProtocol where Self: UIView {
    public static var nibName: String { String(describing: self) }
    public var typeName: String { String(describing: type(of: self)) }
    public static var bundle: Bundle? { Bundle(for: Self.self) }
}

extension NibLoadableViewProtocol where Self: UIViewController {
    public static var nibName: String { String(describing: Self.self) }
    public var typeName: String { String(describing: type(of: self)) }
    public static var bundle: Bundle? { Bundle(for: Self.self) }
}
