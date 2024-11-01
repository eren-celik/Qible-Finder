//
//  LocationSelectViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 1.07.2024.
//

import Foundation



import CoreLocation

protocol LocationSelectBindingDelegate: BaseDisplayProtocol {
    func dataFetched()
    func updateLocation()
    func switchOffCurrentLocation()
}

protocol LocationSelectViewModelProtocol: CoreLocationProtocol {
    var endpoint: LocationSelectEndpointProtocol! { get set }
    var coordinator: LocationSelectCoordinatorProtocol! { get set }
    var delegate: LocationSelectBindingDelegate! { get set }
    var strings: LocationSelectStringProtocol! { get set }
    var data: [AppLocation]? { get set }
    var locationSelectedHandler: VoidHandler? { get set }
    init(endpoint: LocationSelectEndpointProtocol)
    func serviceGet()
    func getCurrentLocationWithAuthorization()
}

class LocationSelectViewModel: LocationSelectViewModelProtocol {
    var endpoint: LocationSelectEndpointProtocol!
    var coordinator: LocationSelectCoordinatorProtocol!
    weak var delegate: LocationSelectBindingDelegate!
    var strings: LocationSelectStringProtocol!
    var data: [AppLocation]?
    var locationSelectedHandler: VoidHandler?
    
    required init(endpoint: LocationSelectEndpointProtocol = LocationSelectEndpoint()) {
        self.endpoint = endpoint
    }
    
    func serviceGet() {
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                data = try await endpoint?.cities.retrieve()
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
    
    func getCurrentLocationWithAuthorization() {
        requestLocationWithAuthorization(authorizationCompletion: handleAuthorizationCompletion,
                                         deniedCompletion: handleDeniedAuthorizationCompletion,
                                         locationUpdate: handleLocationUpdate)
    }
    
    private func handleAuthorizationCompletion() {
        requestLocation(locationUpdate: handleLocationUpdate)
    }
    
    private func handleDeniedAuthorizationCompletion() {
        delegate?.switchOffCurrentLocation()
    }
    
    private func handleLocationUpdate(location: CLLocation) {
        updateLocationData(from: location)
        debugPrint(location)
    }
    
    private func updateLocationData(from location: CLLocation) {
        Task {
            do {
                let (city, district) = try await GeocoderManager.shared.getCityAndDistrict(from: location)
                UserDefaultsManager.shared.saveCurrentLocation(.init(
                    district: district,
                    city: city,
                    lat: location.coordinate.latitude,
                    lng: location.coordinate.longitude
                ))
                await MainActor.run {
                    delegate?.updateLocation()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

protocol LocationSelectStringProtocol: GeneralStringProtocol {
    var locationOtomaticTitle: String { get }
    var enableLocationServiceTitle: String { get }
    var currentLocationTitle: String { get }
    var locationManuelTitle: String { get }
    var placeholderAddLocation: String { get }
    var selectedLocationDesc: String { get }
}

struct LocationSelectStrings: LocationSelectStringProtocol {
    var locationOtomaticTitle: String { return "Otomatik" }
    var enableLocationServiceTitle: String { return "Konum Servislerini Aç:" }
    var currentLocationTitle: String { return "Mevcut Konum:" }
    var locationManuelTitle: String { return "Elle Eklenen Konumlar" }
    var placeholderAddLocation: String { return "Konum Ekle" }
    var selectedLocationDesc: String { return "Namaz saatleri seçtiğiniz konuma göre gösterilecektir." }
}
