//
//  MosqueMapCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import UIKit


typealias MosqueMapHandler = ((MosqueMap?) -> Void)

class MosqueMapCell: FLCollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mosqueLabel: Label!
    @IBOutlet weak var addressLabel: Label!
    @IBOutlet weak var routeButton: Button!
    @IBOutlet weak var shareButton: Button!
    
    lazy var routeHandler: MosqueMapHandler? = nil
    lazy var shareHandler: MosqueMapHandler? = nil
    
    lazy var data: MosqueMap? = nil
    
    func setUI(data: MosqueMap? = nil, strings: GeneralStringProtocol) {
        guard let data, let imageUrl = data.imageUrl else { return }
        self.data = data
        configureUI()
        
        let url = URL(string: imageUrl)
        imageView.kf.setImage(with: url)
        mosqueLabel.text = data.name
        addressLabel.text = data.address
    }
    
    func configureUI() {
        mosqueLabel.configure(with: .init(font: .xs3Bold, textColor: .blackBase))
        addressLabel.configure(with: .init(font: .xs4SemiBold, textColor: .black100))
        routeButton.configure(
            with: .init(
                style: .blue,
                title: "Yol Tarifi Al",
                leftIcon: UIImage.iconMosqueRouteWhite,
                iconInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
                alignment: .center,
                action: routeButtonHandler
            )
        )
        routeButton.font = .xs4Bold
        
        shareButton.configure(
            with: .init(
                style: .grayBlack,
                title: "Paylaş",
                tintColor: .blackBase,
                leftIcon: UIImage.iconShare,
                iconInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
                alignment: .center,
                action: shareButtonHandler
            )
        )
        shareButton.font = .xs4Bold
    }
    
    func routeButtonHandler() {
        routeHandler?(data)
    }
    
    func shareButtonHandler() {
        shareHandler?(data)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.cornerRadius = cornerRadius8
    }

}
