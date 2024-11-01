//
//  LocationRequestViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 27.06.2024.
//

import UIKit
import CoreLocation
import PanModal

class LocationRequestViewController: BaseLocationViewController {
    var viewModel: LocationRequestViewModelProtocol!
    
    @IBOutlet weak var infoLabel: Label!
    @IBOutlet weak var currentLocationButton: Button!
    @IBOutlet weak var manualLocationButton: Button!
    lazy var popup = AlertPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUI() {
        infoLabel.configure(with: .init(text: viewModel.strings.locationRequestTitle,
                                        font: .xsMedium,
                                        textColor: .primary50,
                                        alignment: .center))
        
        currentLocationButton.configure(
            with: .init(
                style: .white,
                title: viewModel.strings.useCurrentLocation,
                font: .xs3Bold,
                alignment: .center,
                action: useCurrentLocationButtonAction
            )
        )
        
        manualLocationButton.configure(
            with: .init(
                style: .clearWhite,
                title: viewModel.strings.manuelLocation,
                font: .xs3Medium,
                alignment: .center,
                action: showPopupView
            )
        )
    }
    
    func showPopupView() {
        popup.frame = .init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        popup.configure(with: PopupViewModel(title: viewModel.strings.manuelLocation,
                                             desc: viewModel.strings.manuelLocationDesc,
                                             negativeButtonTitle: viewModel.strings.manuelLocation,
                                             negativeButtonAction: addManualLocation,
                                             pozitiveButtonTitle: viewModel.strings.permissionForLocation,
                                             pozitiveButtonAction: currentLocationButtonAction,
                                             style: .blue))
        self.view.addSubview(popup)
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismissDialog()
    }
    
    func useCurrentLocationButtonAction() {
        if LocationManager.shared.isAuthorizationDenied {
            showSettingsAlert(title: "Location Access Denied", message: "Please enable location services in Settings")
        } else {
            viewModel.getCurrentLocationWithAuthorization()
        }
    }
    
    // MARK: HANDLERS
    
    func currentLocationButtonAction() {
        popup.removeFromSuperview()
        useCurrentLocationButtonAction()
    }
}

extension LocationRequestViewController: LocationRequestBindingDelegate {
    func updateLocation() {
        dismissDialog()
    }
    
    func addManualLocation() {
        viewModel.dismissAndPresentLocationSelectHandler?()   
    }
    
}

extension LocationRequestViewController: PanModalProtocol {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight { return .intrinsicHeight }
    var longFormHeight: PanModalHeight { return .maxHeight }
}
