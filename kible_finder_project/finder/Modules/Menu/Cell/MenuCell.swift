//
//  MenuCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit


class MenuCell: FLTableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    
    lazy var data: Menu? = nil
    
    func setUI(data: Menu? = nil, strings: GeneralStringProtocol) {
        self.data = data
        iconView.image = data?.icon
        titleLabel.text = data?.title(using: strings)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.tintColor = .blackBase
        titleLabel.configure(with: .init(font: .xs2SemiBold))
    }
}
