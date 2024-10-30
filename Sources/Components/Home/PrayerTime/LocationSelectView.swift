//
//  LocationSelectView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 6.07.2024.
//

import UIKit


protocol LocationViewModelProtocol {
    var selectLocationHandler: VoidHandler { get set }
}

struct LocationViewModel: LocationViewModelProtocol {
    var selectLocationHandler: VoidHandler
}

class LocationSelectView: BaseNibLoadableView {
    var viewModel: LocationViewModelProtocol!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var locationLabel: Label!

    func configure(with viewModel: LocationViewModelProtocol) {
        self.viewModel = viewModel
        updateLocationUI()
    }
    
    func updateLocationUI() {
        guard let location = UserDefaultsManager.shared.location else { return }
        locationLabel.text = (location.district ?? "-")  + ", " + (location.city ?? "-")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cornerRadius = cornerRadius8
        self.applyBorder(color: .gray300, width: 1)
        locationLabel.configure(with: .init(font: .xs4SemiBold, 
                                            textColor: .whiteBase,
                                            alignment: .center))
    }
    
    @IBAction func selectLocationAction(_ sender: UIButton) {
        viewModel.selectLocationHandler()
    }
}
