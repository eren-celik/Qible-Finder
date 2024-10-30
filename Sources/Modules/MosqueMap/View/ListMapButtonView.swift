//
//  ListMapButtonView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 19.07.2024.
//

import UIKit


protocol ListMapButtonViewModelProtocol {
    var strings: GeneralStringProtocol! { get set }
    var clickedHandler: VoidHandler! { get set }
    var centerMapHandler: VoidHandler? { get set }
    var hideCenterMapButton: Bool! { get set }
}

struct ListMapButtonViewModel: ListMapButtonViewModelProtocol {
    var strings: GeneralStringProtocol!
    var clickedHandler: VoidHandler!
    var centerMapHandler: VoidHandler? = nil
    var hideCenterMapButton: Bool! = false
}

class ListMapButtonView: BaseNibLoadableView {
    var viewModel: ListMapButtonViewModelProtocol!
    
    @IBOutlet weak var listMapButton: Button!
    @IBOutlet weak var mapCenterButton: UIButton!
    
    func configure(with viewModel: ListMapButtonViewModelProtocol!) {
        self.viewModel = viewModel
        setUI()
    }
    
    func setUI() {
        var icon = viewModel.hideCenterMapButton ? UIImage.iconMap : UIImage.iconMapList
        listMapButton.configure(
            with: .init(
                style: .whiteBlack,
                backgroundColor: .white,
                cornerRadius: cornerRadius8,
                rightIcon: icon,
                textInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
                iconInset: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0),
                alignment: .center,
                action: viewModel.clickedHandler
            )
        )
        
        mapCenterButton.isHidden = viewModel.hideCenterMapButton
        listMapButton.text = viewModel.hideCenterMapButton ? "Haritayı Görüntüle" : "Listeyi Görüntüle"
    }
    @IBAction func mapCenterButtonAction(_ sender: Any) {
        viewModel.centerMapHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
