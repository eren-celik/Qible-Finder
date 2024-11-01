//
//  GradientView.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

open class FLGradientView: UIView {
    
    // Gradient layer
    private var gradientLayer: CAGradientLayer!
    
    // Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    // Setup the gradient layer
    private func setupGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Update the gradient layer frame when the view's layout changes
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    // Method to set gradient colors and direction
    public func setGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
    }
}

extension UIColor {
    
    public static func gradientColor(colors: [UIColor], size: CGSize, startPoint: CGPoint = CGPoint(x: 0.5, y: 0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1)) -> UIColor? {
        // Gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        
        // Render the gradient to UIImage
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return UIColor from UIImage
        if let gradientImage = gradientImage {
            return UIColor(patternImage: gradientImage)
        } else {
            return nil
        }
    }
}
