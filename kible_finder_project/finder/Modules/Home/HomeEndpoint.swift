//
//  HomeEndpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 11.06.2024.
//

import Foundation


protocol HomeEndpointProtocol {
    var home: Endpoint { get }
    var prayerTime: Endpoint { get }
}

class HomeEndpoint: Endpoint, HomeEndpointProtocol {
    var home: Endpoint {
        Endpoint(path: "lsBuZm1LbJSp/data", encoding: .urlEncoding)
    }
    var prayerTime: Endpoint {
        Endpoint(path: "nuzim4_YLHKY/data", encoding: .urlEncoding)
    }
}
