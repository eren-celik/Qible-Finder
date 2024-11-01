//
//  HadithCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import UIKit


class HadithCell: FLTableViewCell {
    
    @IBOutlet weak var contentLabel: Label!
    @IBOutlet weak var referanceLabel: Label!
    @IBOutlet weak var shareButton: Button!
    
    lazy var data: Hadith? = nil
    
    func setUI(with data: Hadith?, strings: GeneralStringProtocol) {
        self.data = data
        contentLabel.configure(with: .init(text: data?.content, font: .xs2Medium, textColor: .blackBase , alignment: .left))
        referanceLabel.configure(with: .init(text: data?.referance, font: .xs3Medium, textColor: .black100 , alignment: .right))
        
        shareButton.configure(
            with: .init(
                style: .blue,
                title: strings.share,
                leftIcon: UIImage.iconShare,
                iconInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
                alignment: .center,
                action: shareButtonHandler
            )
        )
    }
    
    func shareButtonHandler() {
        debugPrint("shareButtonHandler")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
