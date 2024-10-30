//
//  MosqueMapEndpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 18.07.2024.
//

import Foundation


protocol MosqueMapEndpointProtocol {
    var mosques: Endpoint { get }
}

class MosqueMapEndpoint: Endpoint, MosqueMapEndpointProtocol {
    var mosques: Endpoint {
        Endpoint(path: "9qF63kNO0QMt/data", encoding: .urlEncoding)
    }
}
