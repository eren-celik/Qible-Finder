//
//  TitleLabeView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit



protocol TitleLabelViewModelProtocol {
    var title: String { get set }
    var buttonTitle: String? { get set }
    var buttonIsHidden: Bool { get set }
    var buttonHandler: VoidHandler? { get set }
}

struct TitleLabelViewModel: TitleLabelViewModelProtocol {
    var title: String
    var buttonTitle: String? = nil
    var buttonIsHidden: Bool = false
    var buttonHandler: VoidHandler?
}

class TitleLabelView: BaseNibLoadableView {
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var allButton: Button!
    
    var viewModel: TitleLabelViewModelProtocol!
    
    func configure(with viewModel: TitleLabelViewModelProtocol) {
        self.viewModel = viewModel
        titleLabel.configure(with: .init(text: self.viewModel.title, font: .xsBold))
        allButton.isHidden = self.viewModel.buttonIsHidden
        allButton.configure(with: .init(style: .clear, title: self.viewModel.buttonTitle,
                                        alignment: .right,
                                        action: self.viewModel.buttonHandler))
    }
}
