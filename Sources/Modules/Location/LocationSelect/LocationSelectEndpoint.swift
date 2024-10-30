//
//  LocationSelectEndpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 1.07.2024.
//



protocol LocationSelectEndpointProtocol {
    var cities: Endpoint { get }
}

class LocationSelectEndpoint: Endpoint, LocationSelectEndpointProtocol {
    var cities: Endpoint {
        Endpoint(path: "vkw9oRt8E4yF/data", encoding: .urlEncoding)
    }

}
