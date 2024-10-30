//
//  LocationRequestViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 27.06.2024.
//

import Foundation
import CoreLocation


protocol LocationRequestBindingDelegate: BaseDisplayProtocol {
    func updateLocation()
    func addManualLocation()
}

protocol LocationRequestViewModelProtocol: CoreLocationProtocol {
    var coordinator: LocationRequestCoordinatorProtocol! { get set }
    var delegate: LocationRequestBindingDelegate! { get set }
    var strings: LocationRequestStringProtocol! { get set }
    var dismissAndPresentLocationSelectHandler: VoidHandler? { get set }
    var locationSelectedHandler: VoidHandler? { get set }
    func getCurrentLocationWithAuthorization()
}

class LocationRequestViewModel: LocationRequestViewModelProtocol {
    var coordinator: LocationRequestCoordinatorProtocol!
    weak var delegate: LocationRequestBindingDelegate!
    var strings: LocationRequestStringProtocol!
    lazy var dismissAndPresentLocationSelectHandler: VoidHandler? = nil
    lazy var locationSelectedHandler: VoidHandler? = nil
    
    func getCurrentLocationWithAuthorization() {
        requestLocationWithAuthorization(authorizationCompletion: handleAuthorizationCompletion,
                                         deniedCompletion: handleDeniedAuthorizationCompletion,
                                         locationUpdate: handleLocationUpdate)
    }
    
    func handleAuthorizationCompletion() {
        requestLocation(locationUpdate: handleLocationUpdate)
    }
    
    func handleDeniedAuthorizationCompletion() {
        delegate?.addManualLocation()
    }
    
    private func handleLocationUpdate(location: CLLocation) {
        updateLocationData(from: location)
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
                    locationSelectedHandler?()
                    delegate?.updateLocation()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

protocol LocationRequestStringProtocol: GeneralStringProtocol {
    var locationRequestTitle: String { get }
    var useCurrentLocation: String { get }
    var permissionForLocation: String { get }
    var manuelLocation: String { get }
    var manuelLocationDesc: String { get }
}

struct LocationRequestStrings: LocationRequestStringProtocol {
    var locationRequestTitle: String { return "Namaz vakitlerini takip edin, en yakın camileri bulun ve kıbleyi hassasiyetle belirleyin." }
    var useCurrentLocation: String { return "Mevcut Konumumu Kullan" }
    var permissionForLocation: String { return "Uygulamaya Konum İzni Ver" }
    var manuelLocation: String { return "Elle Konum Ekle" }
    var manuelLocationDesc: String { return "Vakitleri görebilmek, kıble açısını hesaplama ve yakındaki camiler için bir konum eklemelisiniz." }
}
