//
//  UIViewExtensions.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

extension UIView {
    
    public enum Corners {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    public convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
    }
    
    public static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
    public func applyBorder(color: UIColor, width: CGFloat) {
        border(width: width)
        border(color: color)
    }
    
    public func roundCorners(radius: CGFloat, corners: [Corners] = []) {
        layer.cornerRadius = radius
        corners.forEach { corner in
            layer.maskedCorners.insert(corner.rawValue)
        }
    }
    
    public func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        self.layer.cornerRadius = 0
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: corners,
                                       cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = shapeLayer
    }
    
    public func border(color: UIColor? = .black) {
        layer.borderColor = color?.cgColor
    }
    
    public func border(width: CGFloat = 1) {
        layer.borderWidth = width
    }
    
    public func clearBorder() {
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
    }
    
    public func addShadow(color: UIColor = .black, opacity: Float = 0.25, offset: CGSize = .zero, radius: CGFloat = 5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
    // #7: QUICKLY CREATE A SNAPSHOT OF A UIVIEWCONTROLLER AS A UIIMAGE
    public func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func addBottomLine(_ color: UIColor = .black) {
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
        bottomLayer.backgroundColor = color.cgColor
        bottomLayer.masksToBounds = true
        layer.addSublayer(bottomLayer)
    }
}

extension UIView: RoundableViewProtocol {
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { roundCorners(radius: newValue) }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { border(width: newValue) }
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        }
        set { border(color: newValue) }
    }
}

extension UIView: GradientableViewProtocol {
    
    public func gradientView(colors: [UIColor], locations: [NSNumber] = [0.0, 1.0]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView.Corners: RawRepresentable {
    
    public typealias RawValue = CACornerMask
    
    public init?(rawValue: CACornerMask) {
        switch rawValue {
        case .layerMinXMinYCorner: self = .topLeft
        case .layerMaxXMinYCorner: self = .topRight
        case .layerMinXMaxYCorner: self = .bottomLeft
        case .layerMaxXMaxYCorner: self = .bottomRight
        default: return nil
        }
    }
    
    public var rawValue: CACornerMask {
        switch self {
        case .topLeft: return .layerMinXMinYCorner
        case .topRight: return .layerMaxXMinYCorner
        case .bottomLeft: return .layerMinXMaxYCorner
        case .bottomRight: return .layerMaxXMaxYCorner
        }
    }
}
