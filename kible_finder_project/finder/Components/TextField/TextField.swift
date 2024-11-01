//
//  TextField.swift
//  Flight
//
//  Created by Ugur Cakmakci on 22.04.2024.
//

import UIKit



class TextField: FLTextField {
    private lazy var viewModel: TextField.ViewModel? = nil
    
    public func configure(with viewModel: TextField.ViewModel = .init()) {
        self.viewModel = viewModel
        super.configure(with: viewModel)
    }
    
    func updateStyle(_ style: TextField.Style) {
        self.viewModel?.style = style
        self.font = style.font
        self.textColor = style.textColor
        self.backgroundColor = style.backgroundColor
        self.borderColor = style.borderColor
        self.borderWidth = style.borderWidth
        self.cornerRadius = style.cornerRadius
        self.isUserInteractionEnabled = style.isUserInteractionEnabled
    }
    
    public enum Style {
        case selected
        case disable
        case defaultt
        
        var font: UIFont {
            return .xs3Medium
        }
        
        var isUserInteractionEnabled: Bool {
            switch self {
            case .disable:
                return false
            default:
                return true
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .selected:
                    .blackBase
            case .disable:
                    .black100
            case .defaultt:
                    .black100
            }
        }
        
        var backgroundColor: UIColor {
            .whiteBase
        }
        
        var borderColor: UIColor {
            switch self {
            case .selected:
                    .primaryBase
            case .disable, .defaultt:
                    .black50
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .selected:
                1.5
            case .disable, .defaultt:
                1
            }
        }
        var cornerRadius: CGFloat {
            return cornerRadius8
        }
    }
}

extension TextField {
    public struct ViewModel: FLTextFieldStyleProtocol {
        var style: TextField.Style
        public var text: String?
        public var placeholder: String?
        public var font: UIFont?
        public var textColor: UIColor?
        public var placeholderTextColor: UIColor?
        public var tintColor: UIColor
        public var backgroundColor: UIColor?
        public var borderStyle: UITextField.BorderStyle?
        public var borderColor: UIColor?
        public var borderWidth: CGFloat
        public var cornerRadius: CGFloat
        public var leftIcon: UIImage?
        public var paddingLeftIcon: CGFloat?
        public var rightIcon: UIImage?
        public var paddingRightIcon: CGFloat?
        public var textPadding: UIEdgeInsets?
        public var alignment: NSTextAlignment?
        
        
        public init(style: TextField.Style = .defaultt,
                    text: String? = "",
                    placeholder: String? = "",
                    font: UIFont? = .medium(.s14),
                    textColor: UIColor? = .blackBase,
                    placeholderTextColor: UIColor? = .blackBase,
                    tintColor: UIColor = .blackBase,
                    backgroundColor: UIColor? = .clear,
                    borderStyle: UITextField.BorderStyle = .none,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = 0,
                    cornerRadius: CGFloat = 0,
                    leftIcon: UIImage? = nil,
                    paddingLeftIcon: CGFloat? = nil,
                    rightIcon: UIImage? = nil,
                    paddingRightIcon: CGFloat? = nil,
                    textPadding: UIEdgeInsets? = leftRightPadding,
                    alignment: NSTextAlignment? = .left) {
            
            self.style = style
            self.text = text
            self.placeholder = placeholder
            self.font = style.font
            self.textColor = style.textColor
            self.placeholderTextColor = placeholderTextColor
            self.tintColor = tintColor
            self.backgroundColor = style.backgroundColor
            self.borderStyle = borderStyle
            self.borderColor = style.borderColor
            self.borderWidth = style.borderWidth
            self.cornerRadius = style.cornerRadius
            self.leftIcon = leftIcon
            self.paddingLeftIcon = paddingLeftIcon
            self.rightIcon = rightIcon
            self.paddingRightIcon = paddingRightIcon
            self.textPadding = textPadding
            self.alignment = alignment
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        return true
    }
}
