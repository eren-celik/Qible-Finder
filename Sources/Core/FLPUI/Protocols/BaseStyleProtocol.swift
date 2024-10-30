//
//  File.swift
//  
//
//  Created by Ugur Cakmakci on 22.04.2024.
//

import UIKit

public protocol FLBaseStyleProtocol { 
    var font: UIFont?  { get set }
    var textColor: UIColor? { get set }
    var tintColor: UIColor { get set }
    var backgroundColor: UIColor? { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    var alignment: NSTextAlignment? { get set }
}

