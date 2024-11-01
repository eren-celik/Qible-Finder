//
//  AppButton.swift
//  FLPCore
//
//  Created by Ugur Cakmakci on 23.03.2024.
//



import UIKit

public class Button: FLButton {
    private lazy var viewModel: Button.ViewModel? = nil
    
    public func configure(with viewModel: Button.ViewModel = .init()) {
        self.viewModel = viewModel
        super.configure(with: viewModel)
        if viewModel.style == .blue {
            configureShareButton(self)
        }
        addAction()
    }
    
    func updateStyle(_ style: Button.Style) {
        self.viewModel?.style = style
        self.font = style.font
        self.textColor = style.textColor
        self.backgroundColor = style.backgroundColor
        self.borderColor = style.borderColor
        self.borderWidth = style.borderWidth
        self.cornerRadius = style.cornerRadius
        self.isUserInteractionEnabled = style.isUserInteractionEnabled
        
        if style == .blue {
            configureShareButton(self)
        }
    }
    
    func addAction() {
        self.addTarget(self, action: #selector(selfClicked), for: .touchUpInside)
    }
    
    func configureShareButton(_ button: UIButton) {
        let gradientColor = UIColor.gradientColor(
            colors: [.primaryBase, .primary300],
            size: button.frame.size
        )
        button.backgroundColor = gradientColor
    }
    
    @objc
    func selfClicked() {
        viewModel?.action?()
    }
    
    public enum Style {
        case blue
        case white
        case clear
        case gray
        case grayBlack
        case whiteBlack
        case clearWhite
        case clearRed
        case disable
        
        var font: UIFont {
            return .xs3SemiBold
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
            case .blue, .clearWhite:
                return .whiteBase
            case .white, .clear:
                return .primaryBase
            case .disable, .grayBlack, .whiteBlack:
                return .blackBase
            case .clearRed:
                return .appRed
            case .gray:
                return .black50
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .blue, .clear, .clearWhite, .clearRed, .gray:
                return .clear
            case .disable:
                return .gray400
            case .grayBlack:
                return .white100
            case .white, .whiteBlack:
                return .whiteBase
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .grayBlack, .whiteBlack:
                return .white200
            default:
                return .clear
            }
        }
        
        var borderWidth: CGFloat {
            switch self {
            case .grayBlack, .whiteBlack:
                return 1
            default:
                return 0
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .whiteBlack:
                return cornerRadius8
            default:
                return cornerRadius4
            }
        }
    }
}

extension Button {
    public struct ViewModel: FLButtonStyleProtocol {
        var style: Button.Style
        public var title: String?
        public var font: UIFont?
        public var textColor: UIColor?
        public var tintColor: UIColor
        public var backgroundColor: UIColor?
        public var borderColor: UIColor?
        public var borderWidth: CGFloat
        public var cornerRadius: CGFloat
        public var leftIcon: UIImage?
        public var rightIcon: UIImage?
        public var textInset: UIEdgeInsets?
        public var iconInset: UIEdgeInsets?
        public var alignment: NSTextAlignment?
        public var action: VoidHandler?
        
        public init(style: Button.Style = .blue,
                    title: String? = nil,
                    font: UIFont? = nil,
                    textColor: UIColor? = .black,
                    tintColor: UIColor = .black,
                    backgroundColor: UIColor? = .clear,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = 0,
                    cornerRadius: CGFloat = 0,
                    leftIcon: UIImage? = nil,
                    rightIcon: UIImage? = nil,
                    textInset: UIEdgeInsets? = nil,
                    iconInset: UIEdgeInsets? = nil,
                    alignment: NSTextAlignment? = .center,
                    action: VoidHandler? = nil) {
            self.style = style
            self.title = title
            self.font = style.font
            self.textColor = style.textColor
            self.tintColor = tintColor
            self.backgroundColor = style.backgroundColor
            self.borderColor = style.borderColor
            self.borderWidth = style.borderWidth
            self.cornerRadius = style.cornerRadius
            self.leftIcon = leftIcon
            self.rightIcon = rightIcon
            self.textInset = textInset
            self.iconInset = iconInset
            self.alignment = alignment
            self.action = action
        }
    }
}
