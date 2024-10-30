//
//  Label.swift
//  Flight
//
//  Created by Ugur Cakmakci on 22.04.2024.
//

import UIKit


class Label: FLLabel {
    private lazy var viewModel: Label.ViewModel? = nil
    
    public func configure(with viewModel: Label.ViewModel = .init()) {
        self.viewModel = viewModel
        super.configure(with: viewModel)
    }
}

extension Label {
    public struct ViewModel: FLLabelStyleProtocol {
        public var text: String?
        public var font: UIFont?
        public var textColor: UIColor?
        public var tintColor: UIColor
        public var backgroundColor: UIColor?
        public var borderColor: UIColor?
        public var borderWidth: CGFloat
        public var cornerRadius: CGFloat
        public var textPadding: UIEdgeInsets?
        public var alignment: NSTextAlignment?
        
        public init(text: String? = "",
                    font: UIFont? = .medium(.s14),
                    textColor: UIColor? = .blackBase,
                    tintColor: UIColor = .blackBase,
                    backgroundColor: UIColor? = .clear,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat = 0,
                    cornerRadius: CGFloat = 0,
                    textPadding: UIEdgeInsets? = .zero,
                    alignment: NSTextAlignment? = .left) {
            
            self.text = text
            self.font = font
            self.textColor = textColor
            self.tintColor = tintColor
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
            self.textPadding = textPadding
            self.alignment = alignment
        }
    }
    
}

