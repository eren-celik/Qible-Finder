//
//  FLButton.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol FLButtonStyleProtocol: FLBaseStyleProtocol {
    var title: String? { get set }
    var font: UIFont?  { get set }
    var textColor: UIColor?  { get set }
    var backgroundColor: UIColor? { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    var leftIcon: UIImage? { get set }
    var rightIcon: UIImage? { get set }
    var textInset: UIEdgeInsets? { get set }
    var iconInset: UIEdgeInsets? { get set }
    var action: VoidHandler? { get set }
}

@IBDesignable
open class FLButton: UIButton {
    
    open func configure(with viewModel: FLButtonStyleProtocol) {
        text = viewModel.title
        font = viewModel.font
        textColor = viewModel.textColor
        tintColor = viewModel.tintColor
        backgroundColor = viewModel.backgroundColor
        borderColor = viewModel.borderColor
        borderWidth = viewModel.borderWidth
        cornerRadius = viewModel.cornerRadius
        if let leftIcon = viewModel.leftIcon {
            image = leftIcon
        }
        if let rightIcon = viewModel.rightIcon {
            image = rightIcon
            semanticContentAttribute = .forceRightToLeft
        }
        contentEdgeInsets = viewModel.textInset ?? .zero
        imageEdgeInsets = viewModel.iconInset ?? .zero
    }
}

extension UIButton {
    public var text: String? {
        get { self.title(for: .normal) }
        set { self.setTitle(newValue, for: .normal) }
    }
    
    public var textColor: UIColor? {
        get { self.titleColor(for: .normal) }
        set { self.setTitleColor(newValue, for: .normal) }
    }
    
    public var font: UIFont? {
        get { self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
    
    public var image: UIImage? {
        get { self.image(for: .normal) }
        set { self.setImage(newValue, for: .normal) }
    }
    
    public var selectedImage: UIImage? {
        get { self.image(for: .selected) }
        set { self.setImage(newValue, for: .selected) }
    }
}
