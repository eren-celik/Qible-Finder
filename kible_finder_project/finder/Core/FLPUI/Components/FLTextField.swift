//
//  FLTextField.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol FLTextFieldStyleProtocol: FLBaseStyleProtocol {
    var text: String?  { get set }
    var placeholder: String?  { get set }
    var font: UIFont?  { get set }
    var textColor: UIColor? { get set }
    var placeholderTextColor: UIColor? { get set }
    var tintColor: UIColor { get set }
    var backgroundColor: UIColor? { get set }
    var borderStyle: UITextField.BorderStyle? { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    var leftIcon: UIImage? { get set }
    var paddingLeftIcon: CGFloat? { get set }
    var rightIcon: UIImage? { get set }
    var paddingRightIcon: CGFloat? { get set }
    var textPadding: UIEdgeInsets? { get set }
    var alignment: NSTextAlignment? { get set }
}

open class FLTextField: UITextField {
    var padding: UIEdgeInsets = .zero
    
    open func configure(with viewModel: FLTextFieldStyleProtocol) {
        self.text = viewModel.text
        self.placeholder = viewModel.placeholder
        self.font = viewModel.font
        self.textColor = viewModel.textColor
        self.placeHolderTextColor(viewModel.placeholderTextColor)
        self.tintColor = viewModel.tintColor
        self.backgroundColor = viewModel.backgroundColor
        self.borderStyle = viewModel.borderStyle ?? .none
        self.borderColor = viewModel.borderColor
        self.borderWidth = viewModel.borderWidth
        self.cornerRadius = viewModel.cornerRadius
        
        if let leftIcon = viewModel.leftIcon {
            self.addPaddingLeftIcon(leftIcon, padding: viewModel.paddingLeftIcon ?? 0)
        }
        
        if let rightIcon = viewModel.rightIcon {
            self.addPaddingRightIcon(rightIcon, padding: viewModel.paddingRightIcon ?? 0)
        }
        
        self.padding = viewModel.textPadding ?? .zero
        self.textAlignment = viewModel.alignment ?? .left
        self.clipsToBounds = true
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
