//
//  MosqueCard.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 17.07.2024.
//

import UIKit

protocol MosqueCardViewModelProtocol {
    
}

struct MosqueCardViewModel: MosqueCardViewModelProtocol {
    
}
class MosqueCardView: BaseNibLoadableView {
    var viewModel: MosqueCardViewModelProtocol!
    
    @IBOutlet weak var titleLabelView: TitleLabelView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mosqueLabel: Label!
    @IBOutlet weak var routeButton: Button!
    @IBOutlet weak var allButton: Button!
    
    func configure(with viewModel: MosqueCardViewModelProtocol) {
        self.viewModel = viewModel
        setUI()
    }
    
    func setUI() {
        let gradientColor = UIColor.gradientColor(
            colors: [.primaryBase, .primary300],
            size: bgView.frame.size
        )
        bgView.backgroundColor = gradientColor
        
        titleLabelView.configure(
            with: TitleLabelViewModel(
                title: "En Yakın Camiler",
                buttonIsHidden: true
            )
        )
        
        mosqueLabel.configure(with: .init(text: "Bağcılar Merkez Camii", font: .xsBold, textColor: .whiteBase , alignment: .left))
        routeButton.configure(
            with: .init(
                style: .white,
                title: "Yol Tarifi Al",
                leftIcon: UIImage.iconMosqueRoute,
                iconInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
                alignment: .center,
                action: nil
            )
        )
        
        allButton.configure(
            with: .init(
                style: .white,
                title: "Tüm Camileri Gör",
                alignment: .center,
                action: nil
            )
        )
        
        routeButton.font = .xs4Bold
        allButton.font = .xs4Bold
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.cornerRadius = cornerRadius8
    }
}
