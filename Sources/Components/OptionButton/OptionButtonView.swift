//
//  OptionButtonView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 25.06.2024.
//

import UIKit


protocol OptionButtonViewModelProtocol {
    var hasIcon: Bool { get set }
    var title: String { get set }
    var checkboxHandler: VoidHandler { get set }
}

struct OptionButtonViewModel: OptionButtonViewModelProtocol {
    var hasIcon: Bool
    var title: String
    var checkboxHandler: VoidHandler
    
    init(hasIcon: Bool = false,
         title: String,
         checkboxHandler: @escaping VoidHandler) {
        self.hasIcon = hasIcon
        self.title = title
        self.checkboxHandler = checkboxHandler
    }
    
}

class OptionButtonView: BaseNibLoadableView {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var checkboxButton: Button!
    
    var viewModel: OptionButtonViewModelProtocol!
    var isSelected = false {
        didSet {
            updateUI(isSelected)
        }
    }
    
    func configure(with viewModel: OptionButtonViewModelProtocol) {
        self.viewModel = viewModel
        iconContainerView.isHidden = !self.viewModel.hasIcon
        titleLabel.configure(with: .init(text: self.viewModel.title,
                                         font: .xs2SemiBold,
                                         textColor: .blackBase))
        
        checkboxButton.image = UIImage.iconCheckbox
        checkboxButton.selectedImage = UIImage.iconCheckboxActive
        
    }
    
    private func updateUI(_ isSelected: Bool) {
        isSelected ? applySelectedUI() : applyDefaultUI()
    }
    
    private func applySelectedUI() {
        bgView.applyBorder(color: .primary100, width: constantBorderWidth)
        titleLabel.textColor = .primaryBase
        checkboxButton.isSelected = true
    }
    
    private func applyDefaultUI() {
        bgView.applyBorder(color: .clear, width: 0)
        titleLabel.textColor = .blackBase
        checkboxButton.isSelected = false
    }
    
    @objc private func selfClicked() {
        viewModel.checkboxHandler()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfClicked)))
    }
}
