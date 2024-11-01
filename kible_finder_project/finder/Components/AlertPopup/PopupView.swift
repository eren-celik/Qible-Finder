//
//  PopupView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 30.06.2024.
//

import UIKit


protocol PopupViewModelProtocol {
    var title: String { get set }
    var desc: String { get set }
    var negativeButtonTitle: String? { get set }
    var negativeButtonAction: VoidHandler? { get set }
    var pozitiveButtonTitle: String? { get set }
    var pozitiveButtonAction: VoidHandler? { get set }
    var style: PopupView.PopupStyle { get set}
    
}

struct PopupViewModel: PopupViewModelProtocol {
    var title: String
    var desc: String
    var negativeButtonTitle: String?
    var negativeButtonAction: VoidHandler?
    var pozitiveButtonTitle: String?
    var pozitiveButtonAction: VoidHandler?
    var style: PopupView.PopupStyle
}

class PopupView: BaseNibLoadableView {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var descLabel: Label!
    @IBOutlet weak var positiveButton: Button!
    @IBOutlet weak var negativeButton: Button!
    @IBOutlet weak var trailingBorder: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var viewModel: PopupViewModelProtocol!
    
    func configure(with viewModel: PopupViewModelProtocol) {
        self.viewModel = viewModel
        
        titleLabel.configure(with: .init(text: self.viewModel.title, font: .xs3Bold, textColor: .blackBase, alignment: .center))
        descLabel.configure(with: .init(text: self.viewModel.desc, font: .xs3Medium, textColor: .black100, alignment: .center))
        
        let axis = self.viewModel.style.axis
        buttonStackView.axis = axis
        trailingBorder.isHidden = axis == .vertical
        
        positiveButton.configure(
            with: .init(
                style: self.viewModel?.style.pozitiveButtonStyle ?? .clear,
                title: self.viewModel?.pozitiveButtonTitle,
                font: .xs2Medium,
                alignment: .center,
                action: self.viewModel?.pozitiveButtonAction
            )
        )
        
        negativeButton.configure(
            with: .init(
                style: self.viewModel?.style.negativeButtonStyle ?? .clear,
                title: self.viewModel?.negativeButtonTitle,
                font: .xs2Medium,
                alignment: .center,
                action: self.viewModel?.negativeButtonAction
            )
        )
    }
    
    enum PopupStyle {
        case grayRed
        case grayBlue
        case blue
        
        var axis: NSLayoutConstraint.Axis {
            switch self {
            case .grayRed, .grayBlue:
                return .horizontal
            case .blue:
                return .vertical
            }
        }
        
        var pozitiveButtonStyle: Button.Style {
            switch self {
            case .grayRed:
                    .clearRed
            case .grayBlue, .blue:
                    .clear
            }
        }
        
        var negativeButtonStyle: Button.Style {
            switch self {
            case .grayRed, .grayBlue:
                    .gray
            case .blue:
                    .clear
            }
        }
    }
    
}
