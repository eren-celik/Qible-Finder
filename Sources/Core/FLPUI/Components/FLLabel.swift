//
//  FLLabel.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol FLLabelStyleProtocol: FLBaseStyleProtocol {
    var text: String?  { get set }
    var font: UIFont?  { get set }
    var textColor: UIColor? { get set }
    var tintColor: UIColor { get set }
    var backgroundColor: UIColor? { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    var textPadding: UIEdgeInsets? { get set }
    var alignment: NSTextAlignment? { get set }
}

open class FLLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    
    open func configure(with viewModel: FLLabelStyleProtocol) {
        self.text = viewModel.text
        self.font = viewModel.font
        self.textColor = viewModel.textColor
        self.tintColor = viewModel.tintColor
        self.backgroundColor = viewModel.backgroundColor
        self.borderColor = viewModel.borderColor
        self.borderWidth = viewModel.borderWidth
        self.cornerRadius = viewModel.cornerRadius
        self.padding = viewModel.textPadding ?? .zero
        self.textAlignment = viewModel.alignment ?? .left
        self.clipsToBounds = true
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }

}


