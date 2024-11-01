//
//  HadithCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import UIKit

import Kingfisher

class HadithCardCell: FLCollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageOverlayView: UIView!
    @IBOutlet weak var dateLabel: Label!
    
    lazy var data: Hadith? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let data, let imageUrl = data.imageUrl else { return }
        let url = URL(string: imageUrl)
        imgView.kf.setImage(with: url)
        dateLabel.text = data.date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOverlayView.cornerRadius = cornerRadius8
        imageOverlayView.clipsToBounds = true
        imageOverlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dateLabel.configure(with: .init(font: .xs2SemiBold, textColor: .whiteBase, alignment: .center))
    }
}
