//
//  LocationInfoView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 21.07.2024.
//

import UIKit

protocol LocationInfoViewModelProtocol {
    
}

struct LocationInfoViewModel: LocationInfoViewModelProtocol {
    
}

class LocationInfoView: BaseNibLoadableView {
    var viewModel: LocationInfoViewModelProtocol!
    
    @IBOutlet weak var infoLabel: Label!
    
    func configure(with viewModel: LocationInfoViewModelProtocol!) {
        infoLabel.setAttributedText(mainText: "Uygulamayı en iyi deneyimle kullanmak için konum servislerini açın.",
                                    mainFont: .xs3Medium,
                                    mainColor: .blackBase,
                                    secondaryText: "konum servislerini",
                                    secondaryFont: .xs3Medium,
                                    secondaryColor: .primaryBase)
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
    }
}
