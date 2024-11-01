//
//  HomeViewModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import Foundation
import CoreLocation

protocol HomeBindingDelegate: BaseDisplayProtocol {
    func homeDataFetched()
    func prayerTimeFetched()
    func locationRequestDismiss()
    func locationSelected()
}

protocol HomeViewModelProtocol: CoreLocationProtocol {
    var endpoint: HomeEndpointProtocol! { get set }
    var menuNavigation: MenuNavigationProtocol! { get set }
    var coordinator: HomeCoordinatorProtocol! { get set }
    var delegate: HomeBindingDelegate! { get set }
    var strings: HomeStringProtocol! { get set }
    var home: Home? { get set }
    var prayerTime: PrayerTime? { get set }
    init(endpoint: HomeEndpointProtocol)
    func serviceGet()
    func servicePrayerTime()
    func getCurrentLocation()
    func getCurrentLocationWithAuthorization()
    func presentSelectLocation()
    func showLocationRequest()
}

class HomeViewModel: HomeViewModelProtocol {
    var endpoint: HomeEndpointProtocol!
    var menuNavigation: MenuNavigationProtocol!
    var coordinator: HomeCoordinatorProtocol!
    weak var delegate: HomeBindingDelegate!
    var strings: HomeStringProtocol!
    var home: Home? = nil
    var prayerTime: PrayerTime? = nil
    
    required init(endpoint: HomeEndpointProtocol = HomeEndpoint()) {
        self.endpoint = endpoint
    }
    
    func serviceGet() {
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                let homeData: HomeResponseData? = try await endpoint?.home.retrieve()
                home = homeData?.data
                await MainActor.run {
                    delegate?.homeDataFetched()
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
    
    func servicePrayerTime() {
        debugPrint("servicePrayerTime")
        Task(priority: .background) {
            do {
                delegate?.startLoading()
                let data: [PrayerTime]? = try await endpoint?.prayerTime.retrieve()
                prayerTime = data?.first
                await MainActor.run {
                    delegate?.prayerTimeFetched()
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
                                         deniedCompletion: handleDeniedAuthorizationCompletion,
                                         locationUpdate: handleLocationUpdate)
    }
    
    func presentSelectLocation() {
        coordinator.presentLocationSelection(with: delegate?.locationSelected)
    }
    
    func showLocationRequest() {
        coordinator.showLocationRequest(with: delegate?.locationRequestDismiss,
                                        locationSelectedHandler: delegate?.locationSelected)
    }
    
    private func handleDeniedAuthorizationCompletion() {
        UserDefaultsManager.shared.currentLocation = nil
        presentSelectLocation()
    }
    
    private func handleAuthorizationCompletion() {
        requestLocation(locationUpdate: handleLocationUpdate)
    }
    
    private func handleLocationUpdate(location: CLLocation) {
        updateLocationData(from: location)
        debugPrint("handleRequestLocationUpdate")
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
                    delegate.locationSelected()
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
protocol HomeStringProtocol: GeneralStringProtocol {}

struct HomeStrings: HomeStringProtocol {}
