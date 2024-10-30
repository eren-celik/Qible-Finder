//
//  QuickAccessMenuCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit


class QuickAccessMenuCell: FLCollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var bgView: FLGradientView!
    lazy var data: Menu? = nil 
    
    func setUI(data: Menu? = nil, strings: GeneralStringProtocol) {
        self.data = data
        iconView.image = data?.icon
        titleLabel.text = data?.title(using: strings)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let colors = [UIColor.primaryBase, UIColor.primary300]
        bgView.setGradient(colors: colors)
        bgView.roundCorners(radius: 8)
        bgView.clipsToBounds = true
        iconView.tintColor = .white
        titleLabel.configure(with: .init(font: .xs3SemiBold, alignment: .center))
    }

}
