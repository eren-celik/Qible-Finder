//
//  UserDefaultManager.swift
//  Flight
//
//  Created by Ugur Cakmakci on 25.04.2024.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var notification: DefaultsKey<[String]> { .init("notificationId", defaultValue: []) }
    var locations: DefaultsKey<[AppLocation]> { .init("location", defaultValue: []) }
    var selectedLocation: DefaultsKey<AppLocation?> { .init("selectedLocation", defaultValue: nil) }
    var currentLocation: DefaultsKey<CurrentLocation?> { .init("currentLocation", defaultValue: nil) }
}

public extension DefaultsSerializable where Self: Codable {
    typealias Bridge = DefaultsCodableBridge<Self>
    typealias ArrayBridge = DefaultsCodableBridge<[Self]>
}

public extension DefaultsSerializable where Self: RawRepresentable {
    typealias Bridge = DefaultsRawRepresentableBridge<Self>
    typealias ArrayBridge = DefaultsRawRepresentableArrayBridge<[Self]>
}

class UserDefaultsManager {
    // Singleton instance
    static let shared = UserDefaultsManager()
    
    // Private initializer to prevent creating instances from outside
    private init() {}
    
    // MARK: - Notification Methods
    
    var notifications: [String] {
        get { Defaults.notification }
        set { Defaults.notification = newValue }
    }
    
    func addNotification(_ notification: String) {
        var currentNotifications = notifications
        currentNotifications.append(notification)
        Defaults.notification = currentNotifications
    }
    
    func removeNotification(_ notification: String) {
        var currentNotifications = notifications
        if let index = currentNotifications.firstIndex(of: notification) {
            currentNotifications.remove(at: index)
        }
        Defaults.notification = currentNotifications
    }
    
    // MARK: - Location Methods
    
    var hasLocation: Bool {
        location != nil
    }
    
    var location: LocationProtocol? {
        if let currentLocation {
            return currentLocation
        } else {
            return selectedLocation
        }
    }
    
    var selectedLocation: AppLocation? {
        get { Defaults.selectedLocation }
        set {
            Defaults.selectedLocation = newValue
            if newValue != nil {
                Defaults.currentLocation = nil
            }
        }
    }
    
    var locations: [AppLocation] {
        get { Defaults.locations }
        set { Defaults.locations = newValue }
    }
    
    func addLocation(_ location: AppLocation) {
        var currentLocations = locations
        if !currentLocations.contains(location) {
            currentLocations.append(location)
            locations = currentLocations
        }
    }
    
    func removeLocation(_ location: AppLocation) {
        var currentLocations = locations
        if let index = currentLocations.firstIndex(of: location) {
            currentLocations.remove(at: index)
            locations = currentLocations
        }
    }
    
    // MARK: - Current Location Methods
    
    var currentLocation: CurrentLocation? {
        get { Defaults.currentLocation }
        set {
            Defaults.currentLocation = newValue
            if newValue != nil {
                Defaults.selectedLocation = nil
            }
        }
    }
    
    func saveCurrentLocation(_ location: CurrentLocation) {
        currentLocation = location
    }
}
