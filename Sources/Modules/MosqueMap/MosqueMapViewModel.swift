//
//  MosqueMapViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import Foundation
import CoreLocation
import MapKit

protocol MosqueMapBindingDelegate: BaseDisplayProtocol {
    func dataFetched()
    func locationAuthorizationDenied()
    func locationUpdate(location: CLLocation)
}

protocol MosqueMapViewModelProtocol: CoreLocationProtocol {
    var endpoint: MosqueMapEndpointProtocol! { get set }
    var coordinator: MosqueMapCoordinatorProtocol! { get set }
    var delegate: MosqueMapBindingDelegate! { get set }
    var strings: MosqueMapStringProtocol! { get set }
    var data: [MosqueMap]? { get set}
    var isAuthorizationDenied: Bool { get }
    var hasAuthorization: Bool { get }
    var hasSelectedLocation: Bool { get }
    var hasCurrentLocation: Bool { get }
    
    init(endpoint: MosqueMapEndpointProtocol)
    func serviceGet()
    func getCurrentLocation()
    func getCurrentLocationWithAuthorization()
    func indexOfAnnotation(_ annotation: MosqueAnnotation) -> Int?
}

class MosqueMapViewModel: MosqueMapViewModelProtocol {
    var endpoint: MosqueMapEndpointProtocol!
    var coordinator: MosqueMapCoordinatorProtocol!
    weak var delegate: MosqueMapBindingDelegate!
    var strings: MosqueMapStringProtocol!
    var data: [MosqueMap]?
    var isAuthorizationDenied = LocationManager.shared.isAuthorizationDenied
    var hasAuthorization = LocationManager.shared.hasAuthorization
    var hasSelectedLocation = UserDefaultsManager.shared.selectedLocation != nil
    var hasCurrentLocation = UserDefaultsManager.shared.currentLocation != nil
    
    required init(endpoint: MosqueMapEndpointProtocol = MosqueMapEndpoint()) {
        self.endpoint = endpoint
    }
    
    func serviceGet() {
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                data = try await endpoint?.mosques.retrieve()
                await MainActor.run {
                    delegate?.dataFetched()
                    delegate?.endLoading()
                }
            } catch let error {
                await MainActor.run {
                    delegate?.endLoading()
                    delegate?.display(error: error)
                }
            }
        }
    }
    
    func getCurrentLocation() {
        requestLocation(locationUpdate: handleLocationUpdate)
    }
    
    func getCurrentLocationWithAuthorization() {
        requestLocationWithAuthorization(authorizationCompletion: handleAuthorizationCompletion,
                                         deniedCompletion: handleDeniedCompletion,
                                         locationUpdate: handleLocationUpdate)
    }
    
    func indexOfAnnotation(_ annotation: MosqueAnnotation) -> Int? {
        guard let data else { return nil }
        return data.firstIndex { $0.id == annotation.id }
    }

    //MARK: - HANDLES
    
    private func handleAuthorizationCompletion() {
        requestLocation(locationUpdate: handleLocationUpdate)
    }
    
    private func handleDeniedCompletion() {
        delegate.locationAuthorizationDenied()
    }
    
    private func handleLocationUpdate(location: CLLocation) {
        delegate.locationUpdate(location: location)
    }
}

protocol MosqueMapStringProtocol: GeneralStringProtocol {
    var placeholderSearchMosque: String { get }
}

struct MosqueMapStrings: MosqueMapStringProtocol {
    var placeholderSearchMosque: String { return "Cami Ara" }
}
