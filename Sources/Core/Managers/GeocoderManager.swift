//
//  GeocoderManager.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 5.07.2024.
//

import CoreLocation

class GeocoderManager {
    
    static let shared = GeocoderManager()
    
    private init() {}
    
    func getCityAndDistrict(from location: CLLocation) async throws -> (city: String?, district: String?) {
        return try await withCheckedThrowingContinuation { continuation in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let placemark = placemarks?.first {
                    let city = placemark.locality
                    let district = placemark.subLocality
                    continuation.resume(returning: (city, district))
                } else {
                    continuation.resume(throwing: NSError(domain: "GeocoderError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No placemarks found"]))
                }
            }
        }
    }
}

