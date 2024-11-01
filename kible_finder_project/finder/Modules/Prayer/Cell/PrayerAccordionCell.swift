//
//  PrayerAccordionCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import UIKit


class PrayerAccordionCell: FLCollectionViewCell {
    
    @IBOutlet weak var titleLabel: Label!
    
    lazy var data: Prayer? = nil {
        didSet {
            setUI()
        }
    }
    
    var isLastCell = false {
        didSet {
            if isLastCell {
                self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
            } else {
                self.layer.cornerRadius = 0
                self.layer.mask = nil
            }
        }
    }
    
    func setUI() {
        titleLabel.configure(with: .init(text: data?.title, font: .xs2Medium, textColor: .blackBase))
    }
}
