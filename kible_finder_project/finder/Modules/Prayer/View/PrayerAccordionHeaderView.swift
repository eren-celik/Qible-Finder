//
//  PrayerAccordionHeaderView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import UIKit


class PrayerAccordionHeaderView: BaseCollectionNibLoadableView {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var descLabel: Label!
    @IBOutlet weak var iconButton: Button!
    
    lazy var enpandActionHandler: IntHandler? = nil
    lazy var section: Int = 0
    lazy var data: PrayerSection? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let data else { return }
        updateCornerRadius(isExpanded: data.isExpanded)
        titleLabel.configure(with: .init(text: data.title, font: .xs2SemiBold, textColor: .blackBase, alignment: .left))
        descLabel.configure(with: .init(text: data.desc, font: .xs3Medium, textColor: .black100, alignment: .left))
        iconButton.image = UIImage.iconArrowDown
        iconButton.selectedImage = UIImage.iconArrowUp
        iconButton.isSelected = data.isExpanded
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfClicked)))
    }
    
    
     func updateCornerRadius(isExpanded: Bool) {
         if isExpanded {
             bgView.roundCorners(corners: [.topLeft,.topRight], radius: 8)
         } else {
             bgView.roundCorners(radius: 8)
//             bgView.layer.mask = nil
         }
     }
    
    @objc private func selfClicked() {
        enpandActionHandler?(section)
    }
    
    @IBAction func iconButtonTapped(_ sender: Any) {
        enpandActionHandler?(section)
    }
    
    
}
