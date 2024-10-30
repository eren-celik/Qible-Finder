//
//  AlertPopupView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 30.06.2024.
//

import UIKit

class AlertPopupView: BaseNibLoadableView {

    @IBOutlet weak var popupView: PopupView!
    
    func configure(with viewModel: PopupViewModelProtocol) {
        popupView.configure(with: viewModel)
    }
    
}
