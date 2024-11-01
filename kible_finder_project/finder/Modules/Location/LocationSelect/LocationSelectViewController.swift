//
//  LocationSelectViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 1.07.2024.
//

import UIKit
import CoreLocation
import PanModal

class LocationSelectViewController: BaseLocationViewController {
    var viewModel: LocationSelectViewModelProtocol!
    
    @IBOutlet weak var currentLocationView: CurrentLocationView!
    @IBOutlet weak var locationListView: LocationListView!
    lazy var popup = AlertPopupView()
    var hasLocation = false {
        didSet {
            self.isModalInPresentation = !hasLocation
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationController?.delegate = self
    }
    
    // MARK: - UI Setup
    
    func setUI() {
        currentLocationView.configure(with: CurrentLocationViewModel(
            strings: viewModel.strings,
            requestCurrentLocationHandler: viewModel.getCurrentLocationWithAuthorization,
            authorizationDeniedHandler: handleAuthorizationDenied
        ))
        
        locationListView.configure(with: LocationListViewModel(
            strings: viewModel.strings,
            locationHandler: handleSelectedLocation,
            locationAddedHandler: handleLocationAdded
        ))
        
        viewModel.serviceGet()
    }
    
    private func updateUI() {
        currentLocationView.updateLocation()
        locationListView.updateTableData()
    }
    
    private func dismissAndUpdateLocation() {
        updateUI()
        dismissDialog()
        viewModel.locationSelectedHandler?()
    }
    
    // MARK: - Popup View
    
    private func showPopupView(data: AppLocation) {
        popup.frame = view.bounds
        popup.configure(with: PopupViewModel(
            title: data.city ?? "",
            desc: viewModel.strings.selectedLocationDesc,
            negativeButtonTitle: viewModel.strings.cancel,
            negativeButtonAction: handlePopupCancelAction,
            pozitiveButtonTitle: viewModel.strings.ok,
            pozitiveButtonAction: handlePopupOkAction,
            style: .grayBlue
        ))
        view.addSubview(popup)
    }
    
    // MARK: - Bubble View
    
    private func showBubbleView() {
        let bubbleView = BubbleView(frame: CGRect(
            x: (view.frame.width - 200) / 2,
            y: view.safeAreaInsets.top + 40,
            width: 200,
            height: 40
        ))
        bubbleView.show(message: "Konum Eklendi", icon: UIImage.iconCheckboxActive)
    }
    
    // MARK: - Handlers
    
    private func handlePopupCancelAction() {
        UserDefaultsManager.shared.selectedLocation = nil
        popup.removeFromSuperview()
    }
    
    private func handlePopupOkAction() {
        UserDefaultsManager.shared.currentLocation = nil
        viewModel.locationSelectedHandler?()
        popup.removeFromSuperview()
        dismissDialog()
    }
    
    private func handleAuthorizationDenied() {
        showSettingsAlert(title: "Location Access Denied", message: "Please enable location services in Settings")
    }
    
    private func handleSelectedLocation() {
        guard let data = UserDefaultsManager.shared.selectedLocation else { return }
        showPopupView(data: data)
    }
    
    private func handleLocationAdded() {
        showBubbleView()
    }
}

// MARK: - LocationSelectBindingDelegate

extension LocationSelectViewController: LocationSelectBindingDelegate {
    func dataFetched() {
        locationListView.setData(data: viewModel.data)
        debugPrint("dataFetched")
    }
    
    func updateLocation() {
        dismissAndUpdateLocation()
    }
    
    func switchOffCurrentLocation() {
        currentLocationView.switchOffCurrentLocation()
    }
}

// MARK: - PanModalPresentable

extension LocationSelectViewController: PanModalPresentable {
    var panScrollable: UIScrollView? { return nil }
    var allowsDragToDismiss: Bool { return false }
    var longFormHeight: PanModalHeight { return .maxHeightWithTopInset(20) }
}

extension LocationSelectViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        UserDefaultsManager.shared.hasLocation
    }
}
