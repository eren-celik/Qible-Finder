import Foundation
import CoreLocation


public typealias UpdateLocationHandler = ((CLLocation) -> Void)

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var updateLocationHandler: UpdateLocationHandler?
    private var authorizationCompletion: VoidHandler?
    private var authorizationNotDetermined: VoidHandler?
    private var authorizationDeniedCompletion: VoidHandler?
    
    var authorizationStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    var hasAuthorization: Bool {
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    var isAuthorizationDenied: Bool {
        return authorizationStatus == .denied
    }
    
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func stopUpdatingLocation() {
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocationUpdate(handler: UpdateLocationHandler?) {
        updateLocationHandler = handler
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func requestAuthorization(completion: VoidHandler? = nil, deniedCompletion: VoidHandler? = nil, notDeterminedCompletion: VoidHandler? = nil) {
        authorizationCompletion = completion
        authorizationDeniedCompletion = deniedCompletion
        authorizationNotDetermined = notDeterminedCompletion
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func handleAuthorizationStatus() {
        switch authorizationStatus {
        case .notDetermined:
            authorizationNotDetermined?()
        case .denied, .restricted:
            authorizationDeniedCompletion?()
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationCompletion?()
        @unknown default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            stopUpdatingLocation() // Stop the location updates after receiving the location
            updateLocationHandler?(location)
        }
    }
}
