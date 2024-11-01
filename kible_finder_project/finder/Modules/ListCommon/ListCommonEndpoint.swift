//
//  MessageEndpoint.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 22.06.2024.
//

import Foundation


protocol ListCommonEndpointProtocol {
    var messages: Endpoint { get }
    var names: Endpoint { get }
    var hadiths: Endpoint { get }
    var calendar: Endpoint { get }
}

class ListCommonEndpoint: Endpoint, ListCommonEndpointProtocol {
    var messages: Endpoint {
        Endpoint(path: "poHfttX5_lz1/data", encoding: .urlEncoding)
    }

    var names: Endpoint {
        Endpoint(path: "wy5F19UfsLc6/data", encoding: .urlEncoding)
    }
    
    var hadiths: Endpoint {
        Endpoint(path: "JRxfJmCAU8sR/data", encoding: .urlEncoding)
    }
    
    var calendar: Endpoint {
        Endpoint(path: "wbwCv_qQLZej/data", encoding: .urlEncoding)
    }
}
