//
//  NamesCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import UIKit


class NamesCell: FLTableViewCell {
    
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var descLabel: Label!
    @IBOutlet weak var arabicLabel: Label!
    
    lazy var data: Names? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        nameLabel.configure(with: .init(text: data?.name, font: .xs2Bold, textColor: .blackBase , alignment: .left))
        descLabel.configure(with: .init(text: data?.desc, font: .xs3Medium, textColor: .black100 , alignment: .left))
        arabicLabel.configure(with: .init(text: "الرحمن", font: .smMedium, textColor: .blackBase , alignment: .right))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
