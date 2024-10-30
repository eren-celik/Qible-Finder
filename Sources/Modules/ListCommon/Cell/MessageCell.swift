//
//  MessageCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import UIKit


class MessageCell: FLTableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: Label!
    
    lazy var data: Message? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let data, let imageUrl = data.imageUrl else { return }
        let url = URL(string: imageUrl)
        imgView.kf.setImage(with: url)
        titleLabel.text = data.content
        gradientView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.cornerRadius = cornerRadius8
        gradientView.cornerRadius = cornerRadius8
        titleLabel.configure(with: .init(font: .xs3SemiBold, textColor: .whiteBase, alignment: .center))
    }
}
