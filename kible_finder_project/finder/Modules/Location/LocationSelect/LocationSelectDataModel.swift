//
//  LocationSelectDataModel.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 2.07.2024.
//

import Foundation
import SwiftyUserDefaults
import CoreLocation

protocol LocationProtocol {
    var district: String? { get set }
    var city: String? { get set }
}

struct AppLocation: BaseModelProtocol, LocationProtocol, DefaultsSerializable, Equatable {
    var id: String?
    var district: String?
    var city: String?

    static func == (lhs: AppLocation, rhs: AppLocation) -> Bool {
        return lhs.id == rhs.id &&
               lhs.district == rhs.district &&
               lhs.city == rhs.city
    }
}

struct CurrentLocation: BaseModelProtocol, LocationProtocol, DefaultsSerializable {
    var district: String?
    var city: String?
    var lat: Double?
    var lng: Double?
}
