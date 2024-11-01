//
//  PrayerListEndpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 26.06.2024.
//

import Foundation


protocol PrayerListEndpointProtocol {
    var prayers: Endpoint { get }
}

class PrayerListEndpoint: Endpoint, PrayerListEndpointProtocol {
    var prayers: Endpoint {
        Endpoint(path: "H91kW8y0LP4x/data", encoding: .urlEncoding)
    }
}
