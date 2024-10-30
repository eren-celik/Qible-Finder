//
//  CurrentLocationView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 2.07.2024.
//

import UIKit

import CoreLocation

protocol CurrentLocationViewModelProtocol {
    var strings: LocationSelectStringProtocol { get set }
    var requestCurrentLocationHandler: VoidHandler { get set }
    var authorizationDeniedHandler: VoidHandler { get set }
}

struct CurrentLocationViewModel: CurrentLocationViewModelProtocol {
    var strings: LocationSelectStringProtocol
    var requestCurrentLocationHandler: VoidHandler
    var authorizationDeniedHandler: VoidHandler
}

class CurrentLocationView: BaseNibLoadableView {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var openLocationServiceLabel: Label!
    @IBOutlet weak var currentLocationLabel: Label!
    @IBOutlet weak var currentLocationValueLabel: Label!
    @IBOutlet weak var currentLocationContainerView: UIView!
    @IBOutlet weak var switchButton: UISwitch!
    
    var viewModel: CurrentLocationViewModelProtocol!
    
    func configure(with viewModel: CurrentLocationViewModelProtocol) {
        self.viewModel = viewModel
        titleLabel.configure(with: .init(text: viewModel.strings.locationOtomaticTitle, font: .xs3Medium, textColor: .black100))
        openLocationServiceLabel.configure(with: .init(text: viewModel.strings.enableLocationServiceTitle, font: .xs3SemiBold, textColor: .primaryBase))
        currentLocationLabel.configure(with: .init(text: viewModel.strings.currentLocationTitle, font: .xs3SemiBold, textColor: .primaryBase))
        currentLocationContainerView.isHidden = true
        switchButton.tintColor = .primaryBase
        
        updateLocation()
    }
    
    func switchOffCurrentLocation() {
        switchButton.isOn = false
        currentLocationContainerView.isHidden = true
    }
    
    func updateLocation() {
        guard let currentLocation = UserDefaultsManager.shared.currentLocation else { return }
        UserDefaultsManager.shared.selectedLocation = nil
        currentLocationContainerView.isHidden = false
        switchButton.isOn = true
        currentLocationValueLabel.text = currentLocation.city
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        if LocationManager.shared.isAuthorizationDenied {
            switchButton.isOn = false
            debugPrint("AuthorizationDenied")
            viewModel.authorizationDeniedHandler()
        } else {
            currentLocationContainerView.isHidden = !switchButton.isOn
            if switchButton.isOn {
                viewModel.requestCurrentLocationHandler()
            } else {
                UserDefaultsManager.shared.currentLocation = nil
            }
        }
    }
}

